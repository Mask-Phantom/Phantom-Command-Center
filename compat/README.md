# Compatibility Modules

This directory contains modular, reusable shell scripts for handling tool-specific setup and validation across TheFatRat.

## Structure

- `common.sh` — Shared utilities (color codes, helper functions)
- `android.sh` — Android SDK/Tools helpers (apktool, baksmali, etc.)
- `environment.sh` — Environment setup and PATH management
- `dependencies.sh` — Dependency checking and installation
- `report.sh` — Installation reporting and logging

## Android Module (`android.sh`)

### Functions

#### `check_apktool_version()`
Verifies apktool is installed and at version v2.6.0.

**Returns:**
- `0` if version matches
- `1` if not found or version mismatch

#### `install_apktool(path, log, config, inst, stp)`
Installs/updates apktool from local tools directory.

**Parameters:**
- `path` — Root installation path
- `log` — Log file path
- `config` — Config file
- `inst` — Installation status file
- `stp` — Setup stop flag file

#### `setup_apktool(path, log, config, inst, stp, green, red)`
Main handler that checks version and installs/updates as needed.

## Benefits

✓ Modularity — Tools developed independently
✓ Reusability — Functions used in multiple scripts
✓ Maintainability — Easier to update in one place
✓ Clarity — setup.sh becomes more readable
