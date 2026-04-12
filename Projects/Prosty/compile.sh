#!/bin/bash

PROJECT_ROOT="Projects/Prosty"
GENERATED_DIR="$PROJECT_ROOT/generated"

CHIME_OUTPUT="$GENERATED_DIR/chime_manager.lua"
CONTROLLER_OUTPUT="$GENERATED_DIR/main_controller.lua"
FRONT_RADAR_OUTPUT="$GENERATED_DIR/front_radar_manager.lua"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Script directory: $SCRIPT_DIR"
cd "$SCRIPT_DIR/../.."

echo $GENERATED_DIR

# Ensure directory exists
mkdir -p "$GENERATED_DIR"

# Create files if missing
touch "$CHIME_OUTPUT"
touch "$CONTROLLER_OUTPUT"
touch "$FRONT_RADAR_OUTPUT"

preprocessor "./$PROJECT_ROOT/ChimeManager/main.lua" --output "$CHIME_OUTPUT"
preprocessor "./$PROJECT_ROOT/FrontRadarManager/main.lua" --output "$FRONT_RADAR_OUTPUT"
preprocessor "./$PROJECT_ROOT/MainController/main.lua" --output "$CONTROLLER_OUTPUT"

# echo -e "\n"
# echo "Replacing setcolor with live color correction"

# # Replace all but the first occurrence of screen.setColor
# for file in "$BACKGROUND_OUTPUT" "$PREBOOT_OUTPUT" "$BOOTED_OUTPUT"; do
#     if [[ -f "$file" ]]; then
#         awk '
#         {
#             if (!done && sub(/screen\.setColor/, "screen.setColor")) {
#                 done=1
#             } else {
#                 gsub(/screen\.setColor/, "setCorrectedColor")
#             }
#             print
#         }' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
#     fi
# done