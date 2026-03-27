# Introduction to Geometric Machine Learning
**Understanding the shapes, structures and spaces that make modern ML tick.**

---
### <span style="color:lightblue">Overview</span>
Geometric machine learning combines geometry + deep learning to process data that has structure, shape, or spatial relationships.
Traditional ML assumes **flat tabular data**, but real-world data often has complex structure.

Examples:
- Molecules → graphs
- Brains → networks
- Cities → point clouds

The geometry of your data is **signal**, not noise. Ignoring it removes important information.

Before moving on to different geometric representations, we need to first understand what is **Euclidean** and **Non-Euclidean** data.

In simple terms:
- Euclidean data → organized in a **regular grid**
- Non-Euclidean data → organized in **irregular structures** like graphs or manifolds
##### 1. Euclidean Data (Regular Structure)
Examples:
- Images
- Audio signals
- Time series
Characteristics:
- Data lies on a fixed grid
- Each point has consistent neighbors
- Distance is straightforward (x, y coordinates)
##### 2. Non-Euclidean Data (Irregular Structure)
Examples:
- Graphs
- Social networks
- 3D meshes
- Molecules
- Point clouds
Characteristics:
- No fixed grid
- Number of neighbors varies
- Relationships matter more than coordinates

---
### <span style="color:lightblue">Core Geometric Representations</span>
The major geometric data representations used in geometric ML are :
- Point Clouds
- Meshes
- Graphs
- Manifolds
- Implicit Surfaces (SDF - Signed distance fields)
- Voxel grids

---
#### <span style="color:lightblue">1. Point Clouds</span>
What Is a Point Cloud?
A point cloud is the simplest and most direct geometric representation: an unordered set of points in 3D space (or higher dimensions). Each point is a coordinate [ (x, y, z) ] and optionally carries additional attributes such as color (RGB), intensity, or surface normal.

Formally, a point cloud P is just:
$$
P = \{p_1, p_2, \dots, p_n\}$ where each $p_i \in \mathbb{R}^3
$$

![](attachments/Pasted%20image%2020260306232934.png)

##### <span style="color:lightblue">Real-World Sources</span>
• LiDAR sensors on self-driving cars (millions of points per second) 
• RGB-D cameras like Microsoft Kinect and Intel RealSense
• Medical 3D scanning: CT and MRI reconstruction
• Archaeological site mapping and digital heritage preservation 
• Robotics: environment mapping and obstacle detection

##### <span style="color:lightblue">Key Challenges</span>
• Permutation invariance : the output should not depend on input order 
• Variable density : points are sparse in some regions and dense in others
• No explicit connectivity : there are no edges between points 
• Noise and outliers from sensor imperfection

---
#### <span style="color:lightblue">2. Meshes</span>
What is a Mesh?
A polygon mesh is a collection of vertices, edges, and faces that together define the surface of a 3D object. Triangular meshes  where every face is a triangle  are the most common form, and the one most amenable to mathematical analysis. 
Mathematically, a mesh is a simplicial complex: a set of vertices V, edges E, and faces F with consistent orientation and connectivity rules.

![](attachments/Pasted%20image%2020260306233334.png)

---

#### <span style="color:lightblue">3. Graphs </span>
A graph G = (V, E) consists of a set of nodes V and edges E between them. Nodes and edges can carry feature vectors. Graphs are the most general discrete geometric structure and serve as the backbone of Geometric Deep Learning. 

**Converting Point clouds to graphs** : To capture relationships between points, we connect nearby points. Then we get a graph where :
-  Nodes are represented by points
- Edges are represented by connections between nearby points.

How does it helps?
Point clouds have irregular structure. They :
- are not grids like images
- have varying neighbors
- have unordered points
So, graph allow models to learn local geometric relationships such as **curvature, surface shapes and object geometry**

---
#### <span style="color:lightblue">4. Manifolds </span>
What is a Manifold?
A manifold is a space that may look curved globally but locally looks like flat Euclidean space.

![](attachments/Pasted%20image%2020260306235856.png)

Examples of manifolds are :
- Sphere surfaces
- Human body surfaces
- Any smooth curved surface

So, manifold is the curved space itself and **Riemannian geometry** provides the tools to measure geometry on that space.  In Riemannian geometry we study about geodesics, curvature and distances on curved surfaces.

A Riemannian manifold equips each point with an inner product that lets you measure distances and angles locally. Key concepts include: 

• Geodesic: the shortest path between two points along the manifold surface
• Exponential map: maps a tangent vector at a point to a nearby point on the manifold 
• Parallel transport: moving vectors along curves while respecting the manifold's curvature

---
#### <span style="color:lightblue">5. Implicit Surfaces (SDF - Signed distance function) </span>
What is an SDF?
A SDF assigns a distance value to every point in space relative to a surface.
For any point p = (x, y, z) :

$$
SDF(p) = distance from p to the object's surface
$$

The sign tells where the point lies :

	|Value     |    Meaning           |
	|----------|----------------------|
	|positive  |    outside object    |
	|zero      |    exactly on surface|
	|negative  |    inside object     |

![](attachments/Pasted%20image%2020260307001539.png)

SDF allows you to :
-  represent smooth surfaces
- do shape reconstruction
- combine shape mathematically

>SDF represents a 3D object as a distance field in space, while point clouds, graphs, and manifolds represent the surface geometry directly.

---
#### <span style="color:lightblue">6. Voxel grids</span>
A voxel (volumetric pixel) is a small cube in 3D space.
Just like:
- Pixel $\rightarrow$ 2D square
- Voxel $\rightarrow$ 3D cube

A voxel grid divides space into many small cubes.
Suppose we have a 32 x 32 x 32 grid. Each voxel stores whether that region contains part of the object. 

Advantage of voxel is that it is easy for neural networks since voxel form a regular 3D grid, we can use 3D CNNs. Some applications of Voxel includes 3D object classification, medical CT scan analysis, 3D reconstruction.
Voxel grids are very **memory expensive**. For example for resolution 32 x 32 x 32, we need 32,768 voxels. **Memory grows cubically**. This is why modern 3D models often prefers point clouds, implicit SDF and meshes.

![](attachments/Pasted%20image%2020260307002737.png)

