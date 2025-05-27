# 🤝 Contributing to SciMLHub

<div align="center">

Thank you for your interest in contributing to SciMLHub! Your contributions are invaluable in building an inclusive, collaborative community focused on advancing Scientific Machine Learning (SciML).

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Code of Conduct](https://img.shields.io/badge/code%20of%20conduct-ff69b4.svg)](CODE_OF_CONDUCT.md)

</div>

## 📑 Quick Links

- [Ways to Contribute](#-ways-to-contribute)
- [Development Workflow](#-development-workflow)
- [Dataset Guidelines](#-dataset-guidelines)
- [Code Standards](#-code-standards)
- [Communication](#-communication)

## 🌟 Ways to Contribute

We welcome contributions in the following areas:

- 📊 **Datasets**: Submit new scientific datasets
- 🤖 **Models**: Contribute ML models and training scripts
- 📝 **Documentation**: Improve guides and tutorials
- 🐛 **Bug Fixes**: Help resolve issues
- 💡 **Features**: Suggest and implement improvements

## 🛠️ Development Workflow

1. **Fork & Clone**
   ```bash
   git clone https://github.com/scimlhub/scimlhub.git
   cd scimlhub
   ```

2. **Create Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Changes**
   - Follow our coding standards
   - Add tests for new features
   - Update documentation

4. **Submit PR**
   - Push your changes
   - Create a pull request
   - Fill out the PR template

## 📊 Dataset Guidelines

### Required Structure
```
dataset_name/
├── README.md                 # Documentation
├── data/                     # Data files
│   ├── raw/                 # Original data
│   │   ├── simulation_1.vtu
│   │   └── simulation_2.vtu
│   └── processed/           # Preprocessed
│       ├── train.npz
│       └── test.npz
├── metadata/                # Dataset info
│   ├── parameters.json     # Simulation parameters
│   └── statistics.json     # Data statistics
└── scripts/                # Utility scripts
    ├── preprocess.py       # Data preprocessing
    └── train_evaluate.py   # Training/evaluation
```

### Documentation Requirements
- Dataset description and purpose
- Data generation methodology
- File formats and structure
- Usage examples
- Performance benchmarks

### Accepted Formats
- Properiatary (binary/ASCII) files with description of data format
- VTK (.vtu)
- HDF5 (.h5)
- NumPy (.npz)
- CSV/TSV (.csv, .tsv)

## 💻 Code Standards

### Python
- Follow PEP 8
- Use type hints
- Add docstrings
- Write unit tests
- Keep functions focused

Example:
```python
def preprocess_data(
    input_path: str,
    output_path: str,
    normalize: bool = True
) -> None:
    """Preprocess raw simulation data.
    
    Args:
        input_path: Path to raw data files
        output_path: Path to save processed data
        normalize: Whether to normalize the data
    """
    # Implementation
```

<!---
### C++
- Follow Google C++ Style Guide
- Use modern C++ features
- Document public APIs
- Include unit tests

Example:
```cpp
/**
 * @brief Preprocess raw simulation data
 * @param input_path Path to raw data files
 * @param output_path Path to save processed data
 * @param normalize Whether to normalize the data
 */
void preprocess_data(
    const std::string& input_path,
    const std::string& output_path,
    bool normalize = true
);
```
-->
## 📞 Communication

- 💬 **Discussions**: [GitHub Discussions](https://github.com/scimlhub/scimlhub/discussions)
- 🐛 **Issues**: [GitHub Issues](https://github.com/scimlhub/scimlhub/issues)
- 📧 **Email**: Contact Santi Adavani, Karthik Mukundakrishnan

## 🎯 Pull Request Process

1. Update documentation
2. Add tests if applicable
3. Ensure CI passes
4. Get review from maintainers
5. Address feedback
6. Merge when approved

### PR Template
```markdown
## Description
Brief description of changes

## Related Issues
Fixes #(issue)

## Type of Change
- [ ] New dataset
- [ ] New model
- [ ] Bug fix
- [ ] Documentation
- [ ] Feature

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] All tests pass
```

---

<div align="center">
Made with ❤️ by the SciML Community
</div>