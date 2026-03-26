# Lid Driven Cavity — Dataset Description (Sprint 1)

## Source

FlowBench (BGLab, 2024) on Hugging Face
- Repo: BGLab/FlowBench
- Subset: LDC_NSHT_2D_constant-Re/128x128
- License: CC-BY-NC-4.0

## Problem

2D Lid-Driven Cavity with Navier-Stokes + Heat Transfer at constant Reynolds number.
A unit square cavity with a moving top lid drives recirculating flow inside.
The task is to predict velocity, pressure, and temperature fields given the geometry.

## Resolution Used

128x128 grid (1.67 GB total for this resolution)

## Files in the Dataset

- harmonics_lid_driven_cavity_X.npz (125 MB) — Input tensor, harmonics geometry
- harmonics_lid_driven_cavity_Y.npz (442 MB) — Output tensor, harmonics geometry
- nurbs_lid_driven_cavity_X.npz (124 MB) — Input tensor, NURBS geometry
- nurbs_lid_driven_cavity_Y.npz (420 MB) — Output tensor, NURBS geometry
- skelneton_lid_driven_cavity_X.npz (121 MB) — Input tensor, skeleton geometry
- skelneton_lid_driven_cavity_Y.npz (438 MB) — Output tensor, skeleton geometry

## Geometry Types

- Harmonics: boundaries defined by harmonic functions
- NURBS: boundaries defined by Non-Uniform Rational B-Splines
- Skeleton: boundaries defined by skeleton-based parametric shapes

## How to Download

    from huggingface_hub import snapshot_download

    snapshot_download(
        repo_id="BGLab/FlowBench",
        repo_type="dataset",
        local_dir="./data",
        allow_patterns=["LDC_NSHT_2D_constant-Re/128x128/*"]
    )

## Tensor Format

X (input): contains geometry and boundary condition information
Y (output): contains velocity (u, v), pressure (p), and temperature (T) fields
Both stored as .npz (compressed NumPy arrays) at 128x128 spatial resolution.
