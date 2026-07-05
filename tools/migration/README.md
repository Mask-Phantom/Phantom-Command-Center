# TheFatRat-Kali2026 Migration Tools

This directory contains one-time migration scripts used to modernize the legacy
TheFatRat codebase.

## Goals

- Automate repetitive refactoring
- Preserve existing behaviour
- Create backups before modification
- Reduce manual editing errors

## Current Tools

### refactor_chk_tools.py

Replaces legacy:

    which command
    if [ "$?" -eq "0" ]

with:

    if command_exists command; then

while preserving script behaviour.

## Guidelines

1. Always commit before running a migration.
2. Verify the affected script afterwards.
3. Commit immediately after successful verification.
