import os
import re
import argparse
import sys
import pathlib
from collections import Counter
from ..Utils.debug import *
from ..Utils.CharactersAnalysis.analyzer import character_counter

#=====================================================#
# region Debugs
#=====================================================#

def Step_Header() -> bool:
    """
        Step1_Header
        -----
        This function prints the starting information
        on the user's terminal.

        Returns:
            - `True`: An error occured
            - `False`: No error occured
    """
    Debug.Note("===========================================")
    Debug.Note("  ██████████    ███████████      ████████  ")
    Debug.Note("          ██             ██    ██          ")
    Debug.Note("  ████  ██      ████   ██      ██████████  ")
    Debug.Note("          ██             ██            ██  ")
    Debug.Note("  ██████████    ████     ██    ████████    ")
    Debug.Note("===========================================")
    Debug.Info("BRS Basic Lua Preprocessor. v2025.08.03")
    Debug.Note("===========================================")
    return False

#=====================================================#
# region Patterns
#=====================================================#

# Regular expression to match the import directive
IMPORT_PATTERN = re.compile(r'require\s*\(\s*["\']([\w\.]+)["\']\s*\)')
EMPTY_LINE_PATTERN = r'^\s*$'

#=====================================================#
# region Debug definitions
#=====================================================#

def resolve_import_path(import_str, repo_root, file_having_the_import, line_number):
    """Convert dot notation to file path relative to repo root, preserving .lua extension."""
    if import_str.endswith(".lua"):
        Error_Line()
        Debug.Error(f"Require path error. The specified path cannot end with {Debug.YELLOW}.lua")
        Error_In(file_having_the_import, line_number)
        Debug.Error(f"You wrote: {Debug.YELLOW}{import_str}")
        Error_Line()
        sys.exit(2)

    parts = import_str.rsplit('.', 0)  # Split at the last dot
    path = os.path.join(repo_root, *parts[0].split('.')) + '.lua'
    return os.path.normpath(path)


def process_file(file_path, repo_root, imported_files, level, caller, caller_line):
    """Recursively process a Lua file, inlining imports."""

    # Recursively indent the deeper the shit goes.
    tabs = ""
    for i in range(0, level):
        tabs = tabs + "\t"

    if file_path in imported_files:
        Debug.Warning(f"{tabs}Skipped duplicate import: {os.path.relpath(file_path, repo_root)}")
        return ""
    
    debug_file_name = os.path.join(*(file_path.split(os.path.sep)[3:]))
    Debug.Info(f"{tabs}{Debug.MAGENTA}{os.path.basename(file_path)}{Debug.BLUE} : {Debug.GREY}{debug_file_name}")
    imported_files.add(file_path)

    output_lines = [""]
    
    line_number = 0

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            skip_comment_block = False
            for line in f:
                line_number += 1
                stripped_line = line.strip()

                # Start skipping if we detect a BRS tag
                if not skip_comment_block and stripped_line.startswith("-- [BRS]"):
                    skip_comment_block = True
                    continue

                if skip_comment_block:
                    # Stop skipping if it's a block comment or import
                    if stripped_line.startswith("--[["):
                        skip_comment_block = False
                    # Keep skipping regular comments
                    elif stripped_line.startswith("--") or re.match(EMPTY_LINE_PATTERN, line) is not None:
                        continue
                    else:
                        skip_comment_block = False  # End of comment block

                # Handle imports normally
                match = IMPORT_PATTERN.search(line)
                if match:
                    import_path = resolve_import_path(match.group(1), repo_root, file_path, line_number)
                    import_path = os.path.normpath(import_path)
                    Debug.Info(f"{tabs}\tLine {line_number}: {Debug.GREY}require(\"{os.path.basename(import_path)}\")")
                    imported_code = process_file(import_path, repo_root, imported_files, level + 1, debug_file_name, line_number)
                    if len(imported_code) != 0:
                        output_lines.append(imported_code)
                        if not imported_code.endswith("\n"):
                            output_lines.append("\n")
                else:
                    output_lines.append(line)

    except FileNotFoundError:
        Error_Line()
        Debug.Error("File not found error.")
        Error_In(caller, caller_line)
        Debug.Note("The path you gave for the file you're trying to require / import does not exist. Validate the full path parsed by the preprocessor.")
        Debug.Error(f"Base name:      {Debug.YELLOW}{os.path.basename(file_path)}")
        Debug.Error(f"File not found: {Debug.GREY}{os.path.relpath(file_path, repo_root)}")
        Debug.Error(f"Full path:      {Debug.YELLOW}{file_path}")
        Debug.Error(f"Repo root arg:  {Debug.GREY}{repo_root}")
        Debug.Warning("Process terminating early.")
        Error_Line()
        sys.exit(2)

    # output_lines.append(f"-- [End import: {os.path.relpath(file_path, repo_root)}]\n\n")
    return ''.join(output_lines)

def bundle_lua(entry_file_path, repo_root):
    """Entrypoint for the Lua bundler."""
    imported_files = set()
    entry_file_path = os.path.normpath(entry_file_path)
    return process_file(entry_file_path, repo_root, imported_files, 0, "Preprocessor", 0)


def full_repository_path():
    """
        Returns the full path to the root of the repository.
        From which you can get the imports working.
    """
    current_working_directory = os.path.dirname(os.path.abspath(__file__))
    tools_directory = os.path.normpath(current_working_directory + os.sep + os.pardir)
    root_directory = os.path.normpath(tools_directory + os.sep + os.pardir)
    return root_directory

def manage_arguments():
    parser = argparse.ArgumentParser(description="Bundle Lua files with @import directives.")
    parser.add_argument("--entry", required=True, help="Path to the entry point Lua file (relative or absolute).")
    parser.add_argument("--output", default="output.lua", help="Output file path (default: output.lua)")

    args = parser.parse_args()
    return args

# Example usage:
if __name__ == "__main__":
    Step_Header()

    repository_root = full_repository_path()
    Debug.Note(f"Repository root: {Debug.GREY}{repository_root}")

    Debug.NewStep("Parsing arguments")
    arguments = manage_arguments()
    Debug.Success("Parsed")
    
    Debug.NewStep("Validating input target")
    entry_file = os.path.join(repository_root, arguments.entry)
    if not os.path.exists(entry_file):
        Debug.Error("Specified input lua file does not exist.")
        Debug.Error(f"Full path: {Debug.GREY}{entry_file}")
        Debug.Error(f"Given argument: {Debug.GREY}{arguments.entry}")
        sys.exit(2)
    Debug.Success("Validated")

    output_file = os.path.join(repository_root, arguments.output)
    Debug.Note(f"Output destination: {Debug.GREY}{entry_file}")
    Debug.Note(f"Input target: {Debug.GREY}{entry_file}")

    Debug.NewStep("Bundling code...")
    bundled_code = bundle_lua(entry_file, repository_root)

    Debug.NewStep("Saving generated bundle")
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(bundled_code)

    character_counter(bundled_code)