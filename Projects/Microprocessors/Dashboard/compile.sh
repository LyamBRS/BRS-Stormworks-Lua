#!/bin/bash

PROJECT_ROOT="Projects/Microprocessors/Dashboard"
GENERATED_DIR="$PROJECT_ROOT/generated"

BACKGROUND_OUTPUT="$GENERATED_DIR/background.lua"
MANAGER_OUTPUT="$GENERATED_DIR/manager.lua"
PREBOOT_OUTPUT="$GENERATED_DIR/preboot.lua"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Script directory: $SCRIPT_DIR"
cd "$SCRIPT_DIR/../../.."

# Ensure directory exists
mkdir -p "$GENERATED_DIR"

# Create files if missing
touch "$BACKGROUND_OUTPUT"
touch "$MANAGER_OUTPUT"

preprocessor "./$PROJECT_ROOT/background/main.lua" --output "$BACKGROUND_OUTPUT"
preprocessor "./$PROJECT_ROOT/manager/main.lua" --output "$MANAGER_OUTPUT"
preprocessor "./$PROJECT_ROOT/preboot/main.lua" --output "$PREBOOT_OUTPUT"