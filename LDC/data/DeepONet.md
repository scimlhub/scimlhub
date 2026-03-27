# DeepONet: Teaching Neural Networks to Learn Operators

---

## Table of Contents

1. What Problem Are We Actually Solving?
2. The Universal Approximation Theorem for Operators
3. The DeepONet Architecture
4. The Branch Network: Reading the Input Function
5. The Trunk Network: Querying the Output Function
6. How Branch and Trunk Come Together
7. Training Setup and Loss Functions
8. Applications and Benchmarks
9. Variants and Extensions

---

## 1. What Problem Are We Actually Solving?

Consider the following situations:

- A structural engineer needs to simulate how stress distributes through a bridge for hundreds of different load configurations
- A climate scientist needs solutions to an atmospheric flow equation across thousands of different initial conditions

In each case, there's a governing equation, often a PDE  and the job is to solve it repeatedly for different inputs. Traditional numerical solvers (finite element, Runge-Kutta, spectral methods) are accurate but **expensive**. Each new input condition requires a full re-solve, often taking minutes to hours.

The promise of DeepONet: **train once, infer instantly**. 

---

## 2. The Universal Approximation Theorem for Operators

DeepONet isn't just an engineering trick, it has rigorous theoretical foundations. Understanding the theorem, even intuitively, builds confidence in the approach.

### The Classical UAT

You likely know the Universal Approximation Theorem for standard neural networks: a sufficiently wide (or deep) neural network can approximate any continuous function to arbitrary accuracy. This justifies using MLPs for regression and classification.

But this theorem says nothing about _operators_. Functions and operators live at different levels of abstraction.

### Chen & Chen (1995): UAT for Operators

In a landmark 1995 paper, Chen and Chen proved a Universal Approximation Theorem for **operators**:

> A neural network with a specific architecture can approximate any nonlinear continuous operator to arbitrary accuracy, given enough parameters.

The key insight from their proof is the decomposition structure:

$$\mathcal{G}(v)(y) \approx \sum_{k=1}^{p} \underbrace{c_k(v)}_{\text{depends on input } v} \cdot \underbrace{\phi_k(y)}_{\text{depends on query point } y}$$

Read this carefully. The approximation separates into two pieces:

1. **$c_k(v)$** — coefficients that encode _what the input function looks like_. These depend on $v$ (the input function) but not on $y$.
2. **$\phi_k(y)$** — basis functions that encode _where we're evaluating the output_. These depend on the query location $y$ but not on $v$.

The output at any point $y$ is just a **dot product** of these two pieces.

**Analogy: Describing a Song**

Imagine you want to describe a song to someone who will reconstruct it. You might say: "It's 60% rock, 30% blues, 10% jazz." Those percentages ($c_k$) encode the _character_ of the song. The actual sounds of rock, blues, and jazz ($\phi_k$) are fixed building blocks. The final song is assembled by mixing those blocks with your coefficients.

DeepONet does exactly this — but for functions instead of songs.

---

## 3. The DeepONet Architecture

DeepONet, introduced by Lu et al. (2021), directly implements the decomposition from the theorem above.

The architecture has two networks working in parallel:

```
Input function v(x)               Query point y
evaluated at sensors               (where we want
[v(x₁), v(x₂), ..., v(xₘ)]       the output)
         │                               │
         ▼                               ▼
  ┌─────────────┐               ┌─────────────────┐
  │   BRANCH    │               │      TRUNK      │
  │   Network   │               │     Network     │
  │  (any NN)   │               │    (any NN)     │
  └──────┬──────┘               └────────┬────────┘
         │                               │
         │  [c₁, c₂, ..., cₚ]            |  [φ₁, φ₂, ..., φₚ]
         │  (p-dim vector)               │  (p-dim vector)
         └──────────────┬────────────────┘
                        │
                        ▼
                   Dot Product
                   ───────────
                   c · φ = Σ cₖφₖ
                        │
                        ▼
              Output: G(v)(y) ≈ u(y)
```

Two networks, one dot product. That's the entire architecture.

---

## 4. The Branch Network: Reading the Input Function

### What it does

The Branch network's job is to **summarize the input function** into a fixed-size vector of coefficients $[c_1, c_2, \ldots, c_p]$.

### How input functions are fed in

Here's a subtle but important point: neural networks take vectors as input, not functions. So how do you feed a function into a network?

You **evaluate it at a fixed set of sensor points**: ${x_1, x_2, \ldots, x_m}$.

If your input function is a temperature profile over $[0, 1]$, you might evaluate it at 100 evenly spaced points, getting a 100-dimensional vector. This vector is the input to the Branch network.

### Architecture choices

The Branch network can be:

- A simple **MLP** (most common)
- A **CNN** (if input functions have spatial structure)

What matters is the output: a $p$-dimensional vector of coefficients.

### The sensor points are fixed at training time

This is a key design constraint. The sensor locations ${x_1, \ldots, x_m}$ must be consistent across all training examples. You can't have some examples sampled at 50 points and others at 80 points — the Branch network expects a fixed-length input.

This is one of DeepONet's practical constraints, but also what makes the Branch network simple to train.

---

## 5. The Trunk Network: Querying the Output Function

### What it does

The Trunk network's job is to **learn a set of basis functions** for the output space — the building blocks $[\phi_1(y), \phi_2(y), \ldots, \phi_p(y)]$ that, when combined with the Branch coefficients, reconstruct the output function.

### Input: a single query point

The Trunk network takes a single point $y$ (e.g., a spatial coordinate, or a time value) and outputs a $p$-dimensional vector. This represents the value of each basis function at that specific location.

### Why this is powerful

Because $y$ is just a coordinate fed as input, the Trunk network can be evaluated at **any location** — even locations not seen during training. This is what gives DeepONet its ability to predict the output function at arbitrary points.

Want the solution at $y = 0.734$? Just feed $0.734$ into the Trunk network, get the basis values, dot with the Branch coefficients, done.

### Architecture choices

The Trunk network is almost always a **standard MLP**. Its input dimension equals the dimensionality of $y$ (1 for a 1D problem, 2 for a 2D spatial problem, 3 for a 3D problem, etc.). Its output is always $p$-dimensional.

---

## 6. How Branch and Trunk Come Together

### The dot product

Once you have:

- $[c_1, \ldots, c_p]$ from the Branch network (encoding the input function)
- $[\phi_1(y), \ldots, \phi_p(y)]$ from the Trunk network (encoding the output basis at location $y$)

The prediction is simply:

$$\mathcal{G}(v)(y) \approx \sum_{k=1}^{p} c_k \cdot \phi_k(y) + b$$

where $b$ is an optional scalar bias. This is a dot product — $O(p)$ operations.

### A worked example

Say $p = 3$ (simplified). The Branch network says: "This input function looks like: $[0.8, -0.3, 0.5]$." The Trunk network at location $y = 0.5$ says: "The basis values here are $[1.2, 0.4, -0.9]$."

The prediction: $0.8 \times 1.2 + (-0.3) \times 0.4 + 0.5 \times (-0.9) = 0.96 - 0.12 - 0.45 = 0.39$.

### One forward pass, any output point

A critical property: the Branch network runs **once per input function** to compute $[c_1, \ldots, c_p]$. Then the Trunk network can be queried at as many output points as you like, at negligible cost. This is extremely efficient for problems where you need the full output function.

---

## 7. Training Setup and Loss Functions

### Training data format

Each training example is a triple:

$${(v_i,\ y_{ij},\ u_{ij})}$$

where:

- $v_i$ is the $i$-th input function (represented as sensor evaluations)
- $y_{ij}$ are query points where the output is known
- $u_{ij} = \mathcal{G}(v_i)(y_{ij})$ is the ground truth output value at those points

Ground truth data typically comes from a numerical solver run offline. You solve the PDE many times for different $v_i$, record the solutions at various query points, and that's your dataset.

### Loss function

The standard loss is mean squared error over all training pairs and query points:

A **relative $L^2$ loss** is often preferred in practice:

$$\mathcal{L} = \frac{1}{N} \sum_{i=1}^{N} \frac{|\hat{u}_i - u_i|^2}{|u_i|^2}$$

This normalizes for functions of varying magnitude, leading to more stable training.

### Optimizer and schedule

- **Optimizer**: Adam works well out of the box
- **Learning rate**: typically $10^{-3}$, decayed with a step or cosine schedule
- **Batch size**: batching over input functions (not query points); common batch size 20–100

### Physics-informed training

DeepONet can be enhanced with physics knowledge. Instead of (or in addition to) supervised loss on solution values, you can add a **residual loss**: penalize how well the predicted $u$ satisfies the governing PDE at collocation points. This is called **physics-informed DeepONet (PI-DeepONet)** and reduces the amount of labeled data needed.

---

## 8. Applications and Benchmarks

DeepONet has been applied across a striking range of scientific domains.

### Antiderivative Operator

The simplest benchmark: learn the operator that maps $v(x)$ to $\int_0^x v(t),dt$. DeepONet learns this to near-machine precision with a small MLP. It's the "hello world" of operator learning.

### ODE and PDE Systems

DeepONet was demonstrated on:

- **1D diffusion-reaction equations**: mapping initial conditions to time-evolved solutions
- **Burgers' equation**: a nonlinear PDE that models shock formation in fluids
- **Darcy flow**: subsurface fluid flow in porous media

Across these benchmarks, DeepONet achieves relative $L^2$ errors of **0.1–2%** using only a few hundred to a few thousand training samples — far fewer than conventional data-driven models.

### Speed Comparison

|Problem|Numerical Solver|DeepONet Inference|Speedup|
|---|---|---|---|
|1D diffusion-reaction|~1 sec|~1 ms|~1,000×|
|Darcy flow (2D)|~10 min|~5 ms|~120,000×|
|Burgers' equation|~30 sec|~2 ms|~15,000×|


---

## 9. Variants and Extensions

The original DeepONet sparked a family of extensions addressing its limitations.

### Improved DeepONet

The authors themselves proposed modifications to improve accuracy:

- **Modified MLP** with better initialization and activation functions
- **Proper orthogonal decomposition (POD)-DeepONet**: uses POD modes as fixed trunk basis functions instead of learned ones, improving efficiency and interpretability

---

### Mental Model to Keep

> _DeepONet decomposes operator learning into two parallel questions: "What does this input function look like?" (Branch) and "What do the output basis functions look like here?" (Trunk). The answer to the operator query is just how much of each basis function you need — a dot product._

### Further Reading

- **Original DeepONet Paper**: Lu et al., _"Learning nonlinear operators via DeepONet based on the universal approximation theorem of operators"_, Nature Machine Intelligence, 2021. [arxiv.org/abs/1910.03193](https://arxiv.org/abs/1910.03193)
- **Chen & Chen (1995)**: _"Universal approximation to nonlinear operators by neural networks with arbitrary activation functions"_ — the theoretical foundation.
