#!/usr/bin/env python3

from pathlib import Path
import shutil
import re

FILE = Path("chk_tools")

if not FILE.exists():
    print("Error: chk_tools not found.")
    exit(1)

backup = FILE.with_suffix(".bak")
shutil.copy2(FILE, backup)

text = FILE.read_text()

tools = [
    "nc",
    "xterm",
    "dig",
    "mcs",
    "gcc",
    "apache2",
    "gnome-terminal",
    "upx",
    "ruby",
    "gem",
    "openssl",
    "python2",
    "python3",
    "pip3",
]

count = 0

for tool in tools:
    pattern = (
        rf"which {re.escape(tool)}\s*>\s*/dev/null\s*2>&1\s*"
        rf"if\s+\[\s*\"\$\?\"\s*-eq\s*\"0\"\s*\];\s*then"
    )

    replacement = f"if command_exists {tool}; then"

    text, replaced = re.subn(
        pattern,
        replacement,
        text,
        flags=re.MULTILINE,
    )

    count += replaced

FILE.write_text(text)

print(f"Created backup: {backup}")
print(f"Updated {count} dependency checks.")
