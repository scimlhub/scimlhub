# Maize Field — 3D Plant Architecture Reconstruction (Sprint 2)

Comparative analysis of 7 geometric deep learning autoencoders across 4 representations for reconstructing 3D maize plant architecture from laser scan data.

## Dataset

MaizeField3D (BGLab, 2025)
- Source: BGLab/AgriField3D on Hugging Face
- Size: 1,045 field-grown maize plants scanned with a Terrestrial Laser Scanner
- Format: .ply files, each with 10,000 points per plant
- Split: 500 train / 545 test (fixed across all experiments)
- Preprocessing: Subsample to 1,024 points, centre, normalise to unit sphere
- Representations: Point Cloud, Mesh (Ball Pivoting), Voxel Grid, SDF (Distance Transform)

## Models

- DGCNN — Point Cloud input, Chamfer Distance loss
- GCN Mesh — Mesh input (K=16), Chamfer Distance loss
- SDF CNN — SDF 32x32x32 input, MSE + Sign BCE loss
- Voxel CNN — Voxel 64x64x64 input, Binary Cross-Entropy loss
- PointNet++ — Point Cloud input, Chamfer Distance loss
- DeepSDF — Implicit SDF, Clamped L1 + Latent Regularisation loss
- PTv3 — Point Cloud input, Chamfer Distance loss

## Unified Comparison (All Outputs converted to Point Cloud, Chamfer Distance)

1. Voxel CNN — Mean CD: 0.004383
2. GCN Mesh — Mean CD: 0.006209
3. PointNet++ — Mean CD: 0.007712
4. PTv3 — Mean CD: 0.012741
5. SDF CNN — Mean CD: 0.027838
6. DeepSDF — Mean CD: 0.213055

## How to Run

1. Open any notebook in Google Colab (GPU runtime recommended)
2. Run all cells — dataset download, training, and visualisation are self-contained
3. W&B login required for experiment tracking

## Author

Sohom Ghosal — AI/SciML Researcher, Avkalan Labs
