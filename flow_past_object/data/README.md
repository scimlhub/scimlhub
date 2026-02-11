# FPO — Flow Past an Object  
### FNO Training Dataset

This repository contains the dataset and configuration details for learning the Flow Past an Object (FPO) problem using neural operator frameworks such as the Fourier Neural Operator (FNO).

The dataset provides high-resolution, time-dependent CFD simulations of flow past parameterized objects under the incompressible Navier–Stokes equations.

---

## Problem Description

**FPO — Flow Past an Object**

Flow past an object is a fundamental benchmark in computational fluid dynamics, involving unsteady vortex shedding, wake formation, and complex flow–structure interactions.  
This dataset is designed for training and evaluating neural operators on high-resolution, time-dependent flow fields.

---

## Simulation Settings

| Property | Value |
|--------|------|
Problem Type | Time-dependent |
Snapshots per Simulation | 242 |
Governing Equations | Incompressible Navier–Stokes |
Spatial Dimension | 2D |
Grid Resolution | 1024 × 256 |

---

## Geometries

The dataset includes three geometry families representing different parameterizations of the obstacle shape:

- **Harmonics**  
- **NURBS**  
- **SkelNetOn**

Each geometry family introduces controlled shape variations to test model generalization across complex object boundaries.

---

## Dataset Contents

Each simulation sample contains:

- Time-series velocity and pressure fields  
- 242 temporal snapshots per simulation  
- Corresponding object geometry representation  
- High-resolution spatial grids of size 1024 × 256  

The dataset is suitable for learning:

- Temporal flow evolution  
- Geometry-conditioned dynamics  
- Generalization across object shapes

---

## Applications

- Neural operator training (FNO, DeepONet, GNO)  
- Geometry-aware flow prediction  
- Unsteady flow modeling  
- Data-driven CFD surrogate modeling  
- Generalization across shape families

---

## Recommended Usage

This dataset is designed for:

- High-resolution spatiotemporal learning  
- Benchmarking generalization across parameterized geometries  
- Training physics-informed and operator learning models

---

## Notes

The FPO dataset complements classical CFD benchmarks such as Lid-Driven Cavity and Cylinder Flow by introducing complex, parameterized object geometries under realistic flow conditions.
