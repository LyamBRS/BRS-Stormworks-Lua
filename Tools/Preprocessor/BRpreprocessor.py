import os
import re
import argparse
import sys
import pathlib

#=====================================================#
# region Debug definitions
#=====================================================#
class Debug():
    #region ----------- docstring
    """
        Debug
        -----
        This class is responsible for the prints you
        see in the terminal.
    """
    #endregion
    #region ----------- Members
    RED:str = "\033[31m"
    GREEN:str = "\033[32m"
    YELLOW:str = "\033[33m"
    BLUE:str = "\033[34m"
    MAGENTA:str = "\033[35m"
    CYAN:str = "\033[36m"
    GREY:str = "\033[90m"
    RESET:str = "\033[0m"

    currentStep:int = 0
    #endregion
    #region ----------- Methods
    def NewStep(text:str):
        """
            Error
            -----
            This function writes an uniform error message
            inside the terminal.
        """
        Debug.currentStep = Debug.currentStep + 1
        Debug.Step(text)
    # ----------------------------------------------------
    def Error(text:str):
        """
            Error
            -----
            This function writes an uniform error message
            inside the terminal.
        """
        print(f"{Debug.RED}[BRS][ERROR   ]:\t {text}{Debug.RESET}")
    # ----------------------------------------------------
    def Success(text:str=None):
        """
            Success
            -------
            This function writes an uniform success message
            inside the terminal.
        """
        if(text == None):
            print(f"{Debug.GREEN}[BRS][SUCCESS ]{Debug.RESET}")
        else:
            print(f"{Debug.GREEN}[BRS][SUCCESS ]:\t {text}{Debug.RESET}")
    # ----------------------------------------------------
    def Warning(text:str):
        """
            Warning
            -------
            This function writes an uniform warning message
            inside the terminal.
        """
        if(text == None):
            print(f"{Debug.YELLOW}[BRS][WARNING ]{Debug.RESET}")
        else:
            print(f"{Debug.YELLOW}[BRS][WARNING ]:\t {text}{Debug.RESET}")
    # ----------------------------------------------------
    def Question(text:str):
        """
            Question
            --------
            This function writes an uniform question message
            inside the terminal.
        """
        print(f"{Debug.CYAN}[BRS][QUESTION]:\t {text}{Debug.RESET}")
    # ----------------------------------------------------
    def Info(text:str):
        """
            Info
            --------
            This function writes unform information message
            inside the terminal.
        """
        print(f"{Debug.BLUE}[BRS][INFO    ]:\t {text}{Debug.RESET}")
    # ----------------------------------------------------
    def Note(text:str):
        """
            Note
            --------
            This function writes unform note message
            inside the terminal.
        """
        print(f"{Debug.GREY}[BRS][NOTE    ]:\t {text}{Debug.RESET}")
    # ----------------------------------------------------
    def Step(text:str):
        """
            Note
            --------
            This function writes unform note message
            inside the terminal.
        """
        print(f"{Debug.MAGENTA}[BRS][STEP    ]: [{Debug.currentStep}]:\t {text}{Debug.RESET}")
    #endregion
#endregion

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

# Regular expression to match the import directive
IMPORT_PATTERN = re.compile(r'--\s*@import\s+"([\w\.]+\.lua)"')

def resolve_import_path(import_str, repo_root, file_having_the_import, line_number):
    """Convert dot notation to file path relative to repo root, preserving .lua extension."""
    if not import_str.endswith(".lua"):
        Debug.Error("@import error. The specified path did not end with .lua")
        Debug.Error(f"At line {Debug.BLUE}{line_number}")
        Debug.Error(f"Of {Debug.BLUE}{file_having_the_import}")
        Debug.Error(f"You wrote: {Debug.YELLOW}{import_str}")
        raise ValueError("Import path must end with .lua")

    parts = import_str.rsplit('.', 1)  # Split at the last dot
    path = os.path.join(repo_root, *parts[0].split('.')) + '.lua'
    return os.path.normpath(path)


def process_file(file_path, repo_root, imported_files, level):
    """Recursively process a Lua file, inlining imports."""

    # Recursively indent the deeper the shit goes.
    tabs = ""
    for i in range(0, level):
        tabs = tabs + "\t"

    if file_path in imported_files:
        Debug.Warning(f"{tabs}Skipped duplicate import: {os.path.relpath(file_path, repo_root)}")
        return ""
    
    Debug.Info(f"{tabs}{Debug.MAGENTA}{os.path.basename(file_path)}{Debug.BLUE} : {Debug.GREY}{os.path.join(*(file_path.split(os.path.sep)[3:]))}")
    imported_files.add(file_path)

    output_lines = [""]
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            line_number = 0
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
                    if stripped_line.startswith("--[[") or stripped_line.startswith("-- @import"):
                        skip_comment_block = False
                    # Keep skipping regular comments
                    elif stripped_line.startswith("--"):
                        continue
                    else:
                        skip_comment_block = False  # End of comment block

                # Handle imports normally
                match = IMPORT_PATTERN.search(line)
                if match:
                    import_path = resolve_import_path(match.group(1), repo_root, file_path, line_number)
                    import_path = os.path.normpath(import_path)
                    Debug.Info(f"{tabs}\tLine {line_number}: {Debug.GREY}@import {os.path.basename(import_path)}")
                    imported_code = process_file(import_path, repo_root, imported_files, level + 1)
                    output_lines.append(imported_code)
                else:
                    output_lines.append(line)

    except FileNotFoundError:
        Debug.Error("File not found error.")
        Debug.Error(f"File base name: {Debug.YELLOW}{os.path.basename(file_path)}")
        Debug.Error(f"File not found: {Debug.GREY}{os.path.relpath(file_path, repo_root)}")
        Debug.Error(f"File path arg: {Debug.YELLOW}{file_path}")
        Debug.Error(f"Repo root arg: {Debug.GREY}{repo_root}")
        Debug.Warning("Process terminating early.")
        sys.exit(2)

    # output_lines.append(f"-- [End import: {os.path.relpath(file_path, repo_root)}]\n\n")
    return ''.join(output_lines)

def bundle_lua(entry_file_path, repo_root):
    """Entrypoint for the Lua bundler."""
    imported_files = set()
    entry_file_path = os.path.normpath(entry_file_path)
    return process_file(entry_file_path, repo_root, imported_files, 0)


def full_repository_path():
    """
        Returns the full path to the root of the repository.
        From which you can get the imports working.
    """
    current_working_directory = os.getcwd()
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

    # print("Bundled file written to bundled_output.lua")
