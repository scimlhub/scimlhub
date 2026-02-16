# Maize Geometry Dataset for Autoencoder-Based Representation Learning

## Overview
This repository provides a geometric dataset of maize plant structures designed
to support a comparative study of autoencoder models across multiple 3D
representations. The dataset enables systematic evaluation of representation
learning using point clouds, voxel grids, and implicit Signed Distance Fields
(SDFs) within the Geometric Deep Learning framework.

## Scientific Motivation
Three-dimensional representations such as point clouds, voxel grids, and
implicit functions are widely used for modeling complex plant geometry.
Each representation introduces distinct trade-offs in terms of computational
efficiency, reconstruction fidelity, and modeling flexibility. This dataset
facilitates controlled experiments to study these trade-offs for maize plant
geometry, with a focus on unsupervised latent representation learning using
autoencoders.

## Dataset Description
The dataset is derived from the **MaizeField3D** collection, consisting of
high-quality 3D scans of field-grown maize plants acquired via terrestrial
laser scanning (TLS). Each sample represents a single maize plant and is
processed into multiple machine-learning-ready formats to enable consistent
comparisons across representations.

Detailed information about dataset structure, file formats, preprocessing
steps, and train/test splits is provided in [`data/README.md`](data/README.md).

## Scripts and Models
The `scripts/` directory contains implementations of the autoencoder models
used for this study:

1. **3D CNN (Voxel)** – Voxel-based autoencoder using 3D convolutions  
2. **PointNet++** – Point cloud autoencoder with hierarchical feature extraction  
3. **Dynamic Graph CNN (DGCNN)** – Graph-based point cloud autoencoder  
4. **DeepSDF** – Implicit surface auto-decoder for Signed Distance Fields  

These scripts include training and evaluation routines for each representation.

## Report and Slides
Details about experiments and tasks can be found in the following files in
the `metadata/` folder:  

- [`report_geometric_DL.pdf`](metadata/report_geometric_DL.pdf)  
- [`geometric_deep_learning.pptx`](metadata/geometric_deep_learning.pptx)  

## Supported Representations
- **Point Clouds**: Downsampled and normalized 3D point sets  
- **Voxel Grids**: Fixed-resolution volumetric occupancy grids  
- **Signed Distance Fields (SDFs)**: Continuous implicit surface
  representations generated via spatial sampling
