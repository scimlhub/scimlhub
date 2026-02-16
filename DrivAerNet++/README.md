# Surrogate Modelling for DrivAerNet++: Pressure Field & Drag Coefficient

## 1. Overview
This repository implements high-fidelity surrogate models to predict the **surface pressure fields (p)** and **drag coefficients (C_d)** for the **DrivAerNet++** dataset. By leveraging geometric deep learning and operator learning, we bypass expensive Computational Fluid Dynamics (CFD) simulations, providing near-instant aerodynamic assessments of complex passenger vehicle geometries.

## 2. Dataset Description
The dataset is derived from the **DrivAerNet++** collection, consisting of high-quality 3D aerodynamic simulations of passenger vehicles. This dataset serves as a large-scale benchmark for geometric deep learning and operator learning in the automotive domain, as highlighted in the **CarBench** framework.



Each sample represents a unique vehicle configuration simulated via high-fidelity CFD. The data is processed into multiple machine-learning-ready formats (Point Clouds and Graphs) to enable consistent comparisons across different geometric representations.

Detailed information about the dataset structure, `.vtk`, and `.stl` file formats is provided in [`data/README.md`](data/README.md).

---

## 3. Key Models
We implement and modify three state-of-the-art architectures to handle the unstructured nature of aerodynamic data:

* **PointNet++**: A hierarchical feature learner that captures local geometric structures at increasing scales, used for extracting global features for C_d prediction.
* **DeepONet (Deep Operator Network)**: An operator learning framework used for learning the mapping between vehicle geometry (input function) and the resulting pressure fields (output function).
* **RegDGCNN (Regularized Dynamic Graph CNN)**: A modified graph-based approach to capture local geometric relationships between mesh nodes, optimized for high-dimensional regression tasks for both C_d and pressure fields.

---

## 4. Repository Structure
```text
dataset_name/
├── README.md                    # Main documentation
├── data/                        # Data files
│   └── README.md                # Information about the Dataset used
├── metadata/                    # Dataset info
│   └── README.md                # Meta data information 
└── scripts/                     # Model scripts
    ├── drag_coefficient/        # Models for Cd prediction
    │       ├── preprocess.ipynb # Mesh to point cloud conversion
    │       ├── regdgcnn.ipynb   # RegDGCNN model implementation  
    │       └── pointnet.ipynb   # PointNet++ model implementation  
    └── pressure_field/          # Models for pressure field prediction
            ├── DeepONet/        # DeepONet implementation 
            └── RegDGCNN/        # RegDGCNN implementation

```

## 5. Citations
**1. DrivAerNet++ (NeurIPS 2024)**
```text
@article{NEURIPS2024_013cf29a,
    author = {Elrefaie, Mohamed and Morar, Florin and Dai, Angela and Ahmed, Faez},
    booktitle = {Advances in Neural Information Processing Systems},
    doi = {10.52202/079017-0016},
    editor = {A. Globerson and L. Mackey and D. Belgrave and A. Fan and U. Paquet and J. Tomczak and C. Zhang},
    pages = {499--536},
    publisher = {Curran Associates, Inc.},
    title = {DrivAerNet++: A Large-Scale Multimodal Car Dataset with Computational Fluid Dynamics Simulations and Deep Learning Benchmarks},
    year = {2024}
}
```

**2. CarBench** 
```text
@article{elrefaie2025carbenchcomprehensivebenchmarkneural,
    title={CarBench: A Comprehensive Benchmark for Neural Surrogates on High-Fidelity 3D Car Aerodynamics}, 
    author={Mohamed Elrefaie and Dule Shu and Matt Klenk and Faez Ahmed},
    year={2025},
    eprint={2512.07847},
    archivePrefix={arXiv},
    primaryClass={cs.LG},
    url={https://arxiv.org/abs/2512.07847}, 
}
```