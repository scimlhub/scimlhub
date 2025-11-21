# Lid-Driven Cavity Flow — CNO Training Repository

This repository contains the implementation and training workflow for learning the **Lid Driven Cavity (LDC)** flow using the **Convolutional Neural Operator (CNO)**.  
The data is sourced from the **FlowBench** dataset hosted on HuggingFace.

---

## Dataset

### **Download**
The dataset can be downloaded from:

**FlowBench Dataset (HuggingFace):**  
https://huggingface.co/datasets/BGLab/FlowBench

### **Dataset Used**
**LDC — Lid Driven Cavity**

Lid-driven cavity flow is a standard CFD benchmark governed by the incompressible **2D Navier–Stokes equations**.

### **Available Geometries**
The LDC dataset includes three geometry families:

- **Harmonics**
- **NURBS**
- **SkelNetOn**

Each geometry family provides a different parameterization of cavity perturbations, enabling diverse training and testing scenarios for operator-learning models like CNO.