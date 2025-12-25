# MaizeField3D  
### A Curated 3D Point Cloud Dataset of Field-Grown Plants From a Maize Diversity Panel

## Overview

The use of artificial intelligence (AI) in three-dimensional (3D) agricultural research—especially for maize—has been limited by the lack of large-scale, diverse 3D datasets. While 2D image datasets are abundant, they fail to capture essential structural traits such as leaf architecture, plant volume, and spatial organization.

To address this gap, MaizeField3D provides a carefully curated collection of high-quality 3D point clouds of fully field-grown maize plants with diverse genetic backgrounds. The dataset is AI-ready and enables advanced research in maize phenotyping, plant architecture modeling, and structural analysis.

### Key Features

- Over 1,000 high-quality 3D point clouds captured via Terrestrial Laser Scanning  
- Diverse maize genotypes grown under real field conditions  
- Graph-based segmentation isolating leaves and stalks  
- Consistent color labeling by leaf order  
- Rigorous manual quality control for accurate segmentation  
- Rich metadata including leaf count, point cloud quality, and presence of tassels and cobs  
- Multiple resolutions via uniform downsampling: 100k, 50k, 10k points per plant

---

## Dataset Directory Structure

```text
MaizeField3D/
├── MaizeField3d/
│   ├── __init__.py
│   ├── dataset.py
├── setup.py
├── README.md
├── requirements.txt
├── MANIFEST.in
├── Metadata.xlsx
├── PointCloudDownsampler.py
└── datasets/
    ├── FielGrwon_ZeaMays_RawPCD_100k.zip
    ├── FielGrwon_ZeaMays_RawPCD_50k.zip
    ├── FielGrwon_ZeaMays_RawPCD_10k.zip
    ├── FielGrwon_ZeaMays_SegmentedPCD_100k.zip
    ├── FielGrwon_ZeaMays_SegmentedPCD_50k.zip
    ├── FielGrwon_ZeaMays_SegmentedPCD_10k.zip
    ├── FielGrwon_ZeaMays_Reconstructed_Surface_dat.zip
    └── FielGrwon_ZeaMays_Reconstructed_Surface_stl.zip
```

---

## Contents of Dataset Archives

### Raw Point Clouds

| Archive | Files | Description |
|--------|-------|-------------|
| RawPCD_100k | 1045 .ply | 100K points per plant |
| RawPCD_50k  | 1045 .ply | 50K points per plant |
| RawPCD_10k  | 1045 .ply | 10K points per plant |

### Segmented Point Clouds

| Archive | Files | Description |
|--------|-------|-------------|
| SegmentedPCD_100k | 520 .ply | Segmented plant parts |
| SegmentedPCD_50k  | 520 .ply | Segmented plant parts |
| SegmentedPCD_10k  | 520 .ply | Segmented plant parts |

### Reconstructed Surfaces

| Archive | Files | Description |
|--------|-------|-------------|
| Surface_stl | 520 .ply | Reconstructed leaf surfaces |
| Surface_dat | 520 .ply | NURBS surface data |

---

## License

CC-BY-NC-4.0

---

## How to Access

### Download

Download the desired .zip files from the datasets directory.

### Extract

```bash
unzip FielGrwon_ZeaMays_RawPCD_100k.zip
unzip FielGrwon_ZeaMays_RawPCD_50k.zip
unzip FielGrwon_ZeaMays_RawPCD_10k.zip
unzip FielGrwon_ZeaMays_SegmentedPCD_100k.zip
unzip FielGrwon_ZeaMays_SegmentedPCD_50k.zip
unzip FielGrwon_ZeaMays_SegmentedPCD_10k.zip
```

---

## Visualization and Tools

Compatible with:
- MeshLab
- CloudCompare
- Python libraries: open3d, trimesh

### Python Example

```python
import open3d as o3d

pcd = o3d.io.read_point_cloud("FielGrwon_ZeaMays_RawPCD_100k/0001.ply")
o3d.visualization.draw_geometries([pcd])
```

---

## Citation

If you use this dataset in your research, please cite:

```bibtex
@article{kimara2025AgriField3D,
  title   = {AgriField3D: A Curated 3D Point Cloud Dataset of Field-Grown Plants from a Maize Diversity Panel},
  author  = {Kimara, Elvis and Hadadi, Mozhgan and Godbersen, Jackson and Balu, Aditya and Jubery, Zaki and Krishnamurthy, Adarsh and Schnable, Patrick and Ganapathysubramanian, Baskar},
  year    = {2025}
}
```

---

## Applications

- 3D maize phenotyping  
- Plant architecture modeling  
- AI-driven trait extraction  
- Structural analysis and growth modeling  
- Digital agriculture and crop science
