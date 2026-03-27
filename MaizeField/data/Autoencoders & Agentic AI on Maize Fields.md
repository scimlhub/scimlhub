# <span style=color:lightblue>Autoencoders & Agentic AI on Maize Fields</span>

From raw 3D scans of maize plants to intelligent agents that reason about yield, a walkthrough of five autoencoder architectures, two surface-reconstruction algorithms, and an LLM-powered ReAct agent built on real field data.

---

## <span style=color:lightblue>THE FOUNDATION </span>

### A Field Full of Point Clouds

Every experiment in this work starts with the same raw material: the BGLab/MaizeField3D dataset, an open collection of real maize plants captured as 3D point clouds. Each plant is stored as an unordered set of (x, y, z) coordinates, available at three density levels: 10 k, 50 k, and 100 k points per scan.

| TOTAL PLANTS | DENSITY LEVELS | MEAN HEIGHT | TRAIN / TEST |
| ------------ | -------------- | ----------- | ------------ |
| 1,045        | 3              | ~1.85 m     | 120 / 30     |

A quick statistical pass using **Open3D** library revealed something reassuring: plant heights follow a near-normal (bell-curve) distribution, concentrated around 1.7–2.0 m. This suggests uniform field growth conditions and a dataset without extreme outlier bias, a healthy sign before feeding any neural network.

### Ball-Pivoting vs. Poisson: Two Ways to Skin a Point Cloud

Raw points have no surface. Before computing Signed Distance Functions for DeepSDF, we need a mesh. Two classical algorithms were benchmarked:

Ball Pivoting Algorithm (BPA) is geometrically intuitive: imagine a virtual ball of radius r rolling across the point cloud. Wherever it touches three points simultaneously, a triangle is born. The ball then pivots along each edge, accumulating new triangles until the whole surface is covered. BPA is fast and produces clean results on dense, uniformly sampled clouds, which makes it suitable for the 10 k-point maize scans used throughout this project.

Poisson Surface Reconstruction takes an entirely different philosophical approach. Rather than connecting dots, it formulates the surface as the zero-level set of an implicit Signed Distance Function: negative inside the object, positive outside, zero on the boundary. It then solves a global Poisson equation over all the points (and their normals) to recover that SDF field. The result is a watertight, smooth mesh, but at the cost of requiring accurate normal estimates and significantly more compute.

"BPA is a skilled seamstress stitching triangles one at a time; Poisson is a sculptor who carves a surface out of mathematical clay."

In practice, BPA was the workhorse for this project's SDF pre-processing pipeline. Its reconstructed meshes fed directly into the DeepSDF training loop, where normal consistency was enforced post-hoc via Open3D's orient_normals_consistent_tangent_plane.

---

## <span style=color:lightblue>FIVE AUTOENCODER ARCHITECTURES</span>

The central question across all five models is the same: can a neural network compress a 3D maize scan into a compact latent code and then faithfully reconstruct it? Each architecture answers that question in a structurally different way.

### •POINTNET AE

MLP layers + global max-pooling. Treats each point independently, then fuses into a 128-d latent. Chamfer distance loss. Simple baseline that ignores local geometry.

### •VOXEL CNN AE

Converts 1 k points into a 32×32×32 binary occupancy grid, then runs 3D Conv / ConvTranspose layers. BCE loss. Trades resolution for grid regularity.

### •GCN AE

Builds a KNN graph, then propagates features via Graph Convolution (message passing). Excels on meshes with true connectivity; struggles on raw point clouds where KNN edges are approximate.

### •DGCNN AE

Dynamic Graph CNN: EdgeConv layers rebuild the KNN graph at each layer using current feature space, not just raw XYZ. Captures both local and global structure. Best reconstruction quality.

### •TRANSFORMER AE

Linear projection → 4-layer Transformer encoder → global max-pool → MLP decoder. Permutation-invariant attention; does not require an explicit graph. Scalable but data-hungry.

### •DEEPSDF

Not a reconstruction autoencoder but an implicit one: an MLP maps (latent + xyz) → SDF value. Marching cubes extracts the surface. Expressive but sensitive to latent initialisation.

### Voxel CNN vs. DGCNN — The Head-to-Head

When trained identically on 1,045 plants for 200 epochs, the two architectures revealed a sharp performance gap:

DGCNN's log-loss of −6.6 versus Voxel CNN's −2.1 is not merely a number: it reflects the fundamental advantage of operating directly in continuous point-cloud space. Voxelisation discards fine spatial detail, two neighboring points that fall into the same 32×32×32 cell are treated as identical. DGCNN preserves the full 3D coordinates and dynamically rebuilds neighborhood relationships layer by layer.

### DeepSDF: Implicit Shape Representation

DeepSDF takes a philosophically different route. Instead of predicting point coordinates, it learns a continuous signed distance field: a function f(latent, x, y, z) → SDF that returns how far any point in space is from the nearest surface, signed positive outside and negative inside. The surface itself is the zero level set f = 0, extracted via marching cubes.

Training used a FastDeepSDF variant with two MLP blocks and a skip connection (hidden dim 512, latent dim 256), a clamped L1 loss (clamp range ±0.1), and a latent regularization penalty of 1e-4. The learning-rate schedule included a warmup phase, critical because all latent codes are initialized at zero; applying a large LR immediately sends gradients into chaotic territory before the codes have any meaning.

---

## <span style=color:lightblue>AGENTIC SYSTEMS</span>

### When the Model Gets an LLM Brain

Autoencoders compress and reconstruct. But what if you want to ask questions about a plant? Enter the ReAct (Reasoning + Acting) agent pattern: a loop where a large language model alternates between thinking about what to do next, calling a Python tool, and reading the tool's output, repeating until it can synthesize a final answer.

"The LLM cannot hallucinate a plant height, it must call the tool. Grounding language reasoning in real computation is the core promise of Agentic AI."

### MaizeField ReAct Agent

The first agent wraps six Python tools around the raw dataset. A user can ask a natural-language question, "How tall is plant 0001.ply?" and GPT-3.5 orchestrates the answer by calling the appropriate tool, reading its output, and repeating if necessary.

| 1 USER QUESTION                                                   | 2 LLM THOUGHT                                                                               |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| Natural language query, e.g. "What is the average canopy spread?" | GPT-3.5 reasons which tool to call and with what arguments.                                 |
| 3 TOOL EXECUTION                                                  | 4 OBSERVATION → ANSWER                                                                      |
| Python runs on real dataset_stats.ply                             | Tool result flows back into the conversation. Loop repeats until a final answer is reached. |

Short-term memory is implemented by persisting the full conversation_history list outside the function and appending every new turn. On each API call, the entire history is sent, so the agent can reference earlier observations without re-running tools.

### DGCNN + ReAct Agent: Photosynthesis Prediction

The second, more specialized agent adds a trained DGCNN model as a tool. Its goal: predict the photosynthesis potential of any maize plant from its 3D shape. The label used to train the DGCNN was a weighted composite of three geometric proxies leaf surface area (50%), leaf angle quality (30%), and light interception (20%)  computed directly from the .ply geometry.

The DGCNN processes 4,096 points × 6 channels (XYZ + normals) through four EdgeConv layers, aggregates with global max-pooling into a 256-d vector, and regresses a score in [0, 1] via a fully-connected head. The ReAct wrapper ensures the LLM cannot invent a score: every photosynthesis query must route through predict_photosynthesis[path].

### Yield Predictor: Geometry as a Proxy for Harvest

A third downstream application used the frozen DGCNN encoder as a feature extractor. A lightweight 3-layer MLP head was trained on top of the 256-d latent vectors to predict yield in kilograms, using geometric labels derived from:

**yield** = (0.4 × height) + (0.3 × canopy_spread) + (0.3 × density × 0.01)

The combined system — DGCNN encoder → MLP head → ReAct agent — can scan a plant once and instantly return a predicted yield with a High/Moderate/Low classification. This replaces time-consuming manual field measurements and scales effortlessly to thousands of plants.


