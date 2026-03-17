#!/bin/bash

PROJECT_ROOT="Projects/Microprocessors/Dashboard"
GENERATED_DIR="$PROJECT_ROOT/generated"

BACKGROUND_OUTPUT="$GENERATED_DIR/background.lua"
MANAGER_OUTPUT="$GENERATED_DIR/manager.lua"
PREBOOT_OUTPUT="$GENERATED_DIR/preboot.lua"
BOOTED_OUTPUT="$GENERATED_DIR/booted.lua"

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
preprocessor "./$PROJECT_ROOT/booted/main.lua" --output "$BOOTED_OUTPUT"

echo -e "\n"
echo "Replacing setcolor with live color correction"

# Replace all but the first occurrence of screen.setColor
for file in "$BACKGROUND_OUTPUT" "$PREBOOT_OUTPUT" "$BOOTED_OUTPUT"; do
    if [[ -f "$file" ]]; then
        awk '
        {
            if (!done && sub(/screen\.setColor/, "screen.setColor")) {
                done=1
            } else {
                gsub(/screen\.setColor/, "setCorrectedColor")
            }
            print
        }' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
    fi
done