---
description: Makefile-based development workflow for Python projects using Poetry
globs: ["Makefile", "pyproject.toml", "**/*.py"]
alwaysApply: true
---

# Python Project Development Workflow

## Available Makefile Targets

### Setup
- `make setup-init` - Complete first-time setup (configure venv, lock, install all deps)
- `make setup-venv` - Configure Poetry to use .venv in project directory

### Installation
- `make install` - Install main dependencies only
- `make install-dev` - Install main + dev dependencies
- `make install-test` - Install main + test dependencies
- `make install-all` - Install all dependencies (main + dev + test)

### Dependency Management
- `make lock` - Regenerate poetry.lock from pyproject.toml
- `make update-deps` - Update dependencies to latest compatible versions

### Testing
- `make test` - Run unit tests without coverage
- `make test-with-coverage` - Run unit tests with coverage reporting

### Code Quality
- `make lint-python` - Lint Python code with flake8
- `make lint-yaml` - Lint YAML files with yamllint
- `make format-python` - Format Python code with black
- `make pre-commit` - Run all quality checks (format, lint, test)

### Build
- `make build` - Build the Python package

### Cleanup
- `make clean` - Clean test artifacts, build artifacts and temporary files
- `make clean-all` - Clean everything including virtual environment

### Help
- `make help` - Show all available targets

## Project Setup

**Quick Start:**
```bash
make setup-init              # Complete first-time setup
make test-with-coverage      # Verify installation
```

## Python Environment
- **Poetry** - Dependency management
- **Python 3.12+** - Minimum version
- **`.venv/`** - Virtual environment (project-local)
- **Dependencies** in `pyproject.toml`:
  - Test: pytest, pytest-cov
  - Dev: black, flake8, yamllint

## Development Workflow

**Daily development:**
```bash
# 1. Make code changes
# 2. Run all quality checks before committing
make pre-commit             # Format, lint, and test everything
# Or run individual checks:
make format-python          # Auto-format
make lint-python            # Lint Python
make lint-yaml              # Lint YAML
make test-with-coverage     # Test with coverage
make clean                  # Remove artifacts
```

## Template Customization

**Before first use:**
1. **Makefile**: Update `PACKAGE_NAME` (default: `app`) and `TEST_PATH` (default: `tests/`)
2. **Directory**: Rename `app/` to your package name
3. **pyproject.toml**: Update name, version, description, authors
4. **Dependencies**: Add your requirements to `[tool.poetry.dependencies]`