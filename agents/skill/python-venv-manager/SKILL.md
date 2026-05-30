---
name: python-venv-manager
description: Manages python virtual environments by reusing existing ones or creating new ones as a dependency requires.
---
## Instructions

When working with Python projects:

1. **Check for an existing virtual environment**:
   - Look for a `venv`, `.venv`, or `env` directory in the current or parent directories.
   - Check if a `pyvenv.cfg` file exists in these directories.

2. **Reuse the existing environment**:
   - If a valid virtual environment is found, use it for running Python commands or installing dependencies.
   - Ensure you use the python executable within the `bin/` (or `Scripts/` on Windows) directory.

3. **Create a new environment if needed**:
   - If no virtual environment is found, or if a new Python dependency is required that is not present in the current environment, create a new virtual environment.
   - Use `python -m venv .venv` to create the environment.
   - After creation, ensure you use this new environment for subsequent Python-related tasks.

4. **Install dependencies**:
   - Use `pip install <package>` within the active or newly created virtual environment when a dependency is required.
