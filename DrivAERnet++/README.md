# Geometry-Aware Surrogate Modeling for Automotive Aerodynamics

## Overview

This project presents a **geometry-aware machine learning surrogate model** developed using the **DrivAerNet++ dataset**. The surrogate is designed to efficiently encode complex 3D car geometries and accurately predict **aerodynamic surface pressure distributions**, significantly reducing the need for computationally expensive CFD simulations.

The work focuses on learning **compact latent representations** of car meshes and leveraging them to build fast, scalable aerodynamic predictors suitable for data-driven design and optimization workflows.

---

## Primary Objectives

### 1. Compact 3D Geometry Representation

The first objective is to **learn a single, compact latent vector per car mesh** that captures the **entire 3D shape geometry**.

- Each car mesh is encoded into a **low-dimensional latent space**
- The latent vector preserves global and local geometric features
- The original mesh can be **reconstructed solely from the latent representation**

This enables:
- Efficient storage of complex 3D geometries
- Geometry-aware downstream learning
- Shape interpolation and similarity analysis

---

### 2. Aerodynamic Pressure Surrogate Modeling

The second objective is to develop a **fast machine learning surrogate** that predicts **surface pressure fields** directly from geometry.

- The surrogate maps geometry (or its latent representation) to **surface pressure distributions**
- Predictions are performed on the **original car body mesh**
- The model avoids running full CFD solvers during inference

This surrogate:
- Reduces reliance on high-fidelity CFD simulations
- Enables rapid aerodynamic evaluation
- Supports large-scale design exploration and optimization

---

## Datasets Used

### DrivAerNet++: 3D Meshes
- Industry-standard **STL car meshes**
- Multiple body types: fastback, notchback, estateback
- Diverse underbody and wheel configurations
- Used to learn geometry encodings and latent representations

### DrivAerNet++: Pressure
- High-fidelity **surface pressure fields** stored in VTK format
- Pressure defined on car body surfaces
- Corresponds one-to-one with 3D mesh geometries
- Used as supervision for surrogate pressure prediction

---


## Applications

- Rapid aerodynamic screening of new car designs
- Design space exploration and optimization
- Data-driven vehicle aerodynamics research
- Reduced-order modeling for CFD workflows
- Machine learning benchmarks on 3D geometry data

---

## Licensing Notice

This work is built using **DrivAerNet / DrivAerNet++**, which is released under the  
**Creative Commons Attribution–NonCommercial 4.0 International License (CC BY-NC 4.0)**.

This project is intended **strictly for non-commercial research and educational use**.  
Any commercial use of the datasets or derived models is prohibited and subject to enforcement by the **MIT Technology Licensing Office (MIT TLO)**.

---

## Related Dataset Publication

Elrefaie, M., Morar, F., Dai, A., & Ahmed, F. (2024).  
**DrivAerNet++: A Large-Scale Multimodal Car Dataset with Computational Fluid Dynamics Simulations and Deep Learning Benchmarks.**  
*arXiv preprint arXiv:2406.09624*  
DOI: 10.48550/arXiv.2406.09624

---

## Notes

This surrogate model is designed as a **research prototype** and serves as a foundation for future work in:
- Geometry-based learning
- Physics-informed surrogates
- Automotive aerodynamic design automation
