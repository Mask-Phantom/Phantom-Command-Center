# Refactoring Guide: Modularizing Setup Scripts

## Project: TheFatRat-Kali2026

Successfully extracted a 43-line apktool setup block into a reusable modular framework.

## Architecture

setup.sh (orchestration)
    └→ source compat/android.sh
        └→ setup_apktool()
            ├→ check_apktool_version()
            └→ install_apktool()

## Before & After

**Before:** 43 lines of inline code with nested conditions
**After:** 1 function call: setup_apktool(...)

## Key Improvements

- Lines saved: 42 (97.7% reduction in apktool block)
- Reusability: Now can be used in any script
- Testability: Functions can be tested independently
- Maintainability: Update logic in one place

## Module Functions

1. check_apktool_version() - Verify v2.6.0 is installed
2. install_apktool() - Install/update from tools directory
3. setup_apktool() - Main orchestrator

## How to Extend

Apply same pattern to baksmali, dx, aapt, aapt2 by adding:
- check_<tool>_version()
- install_<tool>()
- setup_<tool>()

Then call: setup_<tool>(...) in setup.sh

## Files Modified

- setup.sh: Line 409 (added source), Lines 970-1012 (replaced)
- compat/android.sh: Created (78 lines)
- compat/README.md: Created (42 lines)

## Next Phase

Phase 2: Apply to all Android tools
Phase 3: Extract compilers, network tools, build tools
Phase 4: Unit tests and validation suite

## Benefits

✓ Maintainability
✓ Readability
✓ Testability
✓ Reusability
✓ Scalability
✓ Documentation
