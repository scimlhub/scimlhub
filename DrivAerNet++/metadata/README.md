# Metadata Documentation: DrivAerNet++ Subset Details

## 1. Original Publication
The DrivAerNet++ dataset is introduced in the following publication:

**DrivAerNet++: A Large-Scale Multimodal Car Dataset with Computational Fluid Dynamics Simulations and Deep Learning Benchmarks.** [https://arxiv.org/abs/2406.09624](https://arxiv.org/abs/2406.09624)

---

## 2. Dataset Subsets & Formats
To balance computational efficiency with geometric complexity, this repository utilizes two specific subsets of the DrivAerNet++ collection:

| Task | Subset Name | Source Format | Target Prediction |
| :--- | :--- | :--- | :--- |
| **Pressure Prediction** | DrivAerNet++: Pressure | `.stl` | Surface Pressure Field ($p$) |
| **Drag Coefficient** | DrivAerNet++: 3D Meshes | `.vtk` | Aerodynamic Drag ($C_d$) |

---

## 3. Configuration & Selection Criteria
We focus exclusively on the **F_D_WM_WW_1** configuration, which consists of:
* **Body Type:** Fastback
* **Underbody:** Detailed (D)
* **Mirrors:** With Mirrors (WM)
* **Wheels:** With Wheels (WW)

**Sample Size:** 496 unique simulations.

**Reason for Selection:** Due to the massive size of the full DrivAerNet++ repository, this subset was selected because the **F_D_WM_WW_1** configuration represents the most rigorous design constraints. It includes complex aerodynamic interactions (wheels, mirrors, and detailed underbody) that are essential for testing the robustness of surrogate models.



---

## 4. Preprocessing & Normalization
To make the data suitable for PointNet++, DeepONet, and RegDGCNN, the following steps were applied:

### Geometric Representation
* **Point Cloud Conversion:** All geometries are downsampled to a fixed density of **4,096 points**.
* **Sampling Method:** Farthest Point Sampling (FPS) was used to ensure the point cloud captures critical geometric features (mirrors, spoilers, and wheel arches) more effectively than random sampling.
