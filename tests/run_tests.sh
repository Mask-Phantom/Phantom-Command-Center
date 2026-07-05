#!/bin/bash
# Simple Regression Test Harness for TheFatRat

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
FAILS=0

echo "Running TheFatRat Test Harness..."
echo "---------------------------------"

# 1. Syntax Checks
echo -n "1. Checking syntax of main scripts... "
for script in setup.sh fatrat chk_tools; do
    if ! bash -n "$script" 2>/dev/null; then
        echo -e "\n${RED}[FAIL]${NC} Syntax error in $script"
        FAILS=$((FAILS+1))
    fi
done
if [ $FAILS -eq 0 ]; then echo -e "${GREEN}[OK]${NC}"; fi

# 2. Compatibility Framework Load Test
echo -n "2. Testing compat framework loading... "
if bash -c 'source compat/common.sh && source compat/android.sh' 2>/dev/null; then
    echo -e "${GREEN}[OK]${NC}"
else
    echo -e "\n${RED}[FAIL]${NC} Failed to load compat modules"
    FAILS=$((FAILS+1))
fi

echo "---------------------------------"
if [ $FAILS -eq 0 ]; then
    echo -e "${GREEN}All checks passed! Safe to proceed.${NC}"
    exit 0
else
    echo -e "${RED}$FAILS check(s) failed.${NC}"
    exit 1
fi
