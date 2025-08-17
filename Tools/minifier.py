import os
import re
import argparse
import sys
import pathlib
from collections import Counter

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
    Debug.Info("BRS Basic Lua Minifier. v2025.08.16")
    Debug.Note("===========================================")
    return False

def Error_Line() -> bool:
    Debug.Error(f"{Debug.GREY}===========================================")
    return False

def Error_In(file, at_line):
    Debug.Error(f"Error occured in {Debug.GREY}{file}{Debug.RED} at line {Debug.GREY}{at_line}")

#=====================================================#
# region Patterns
#=====================================================#

# Regular expression to match the import directive
IMPORT_PATTERN = re.compile(r'require\s*\(\s*["\']([\w\.]+)["\']\s*\)')
EMPTY_LINE_PATTERN = r'^\s*$'
STRING_PATTERN = r'''
(?:
    " (?:\\.|[^"\\])* "    # double-quoted strings
  | ' (?:\\.|[^'\\])* '    # single-quoted strings
)
'''

#=====================================================#
# Code character analysis.
#=====================================================#
def analyze_character_usage(full_code):
    analyze_constants(full_code)
    analyze_strings(full_code)

def remove_strings_and_comments(code):
    pattern = r"""
        (?:--\[\[.*?\]\])           # multi-line comment
        | (?:--[^\n]*)              # single-line comment
        | (?:"(?:\\.|[^"\\])*")     # double-quoted string
        | (?:'(?:\\.|[^'\\])*')     # single-quoted string
    """
    return re.sub(pattern, '', code, flags=re.DOTALL | re.VERBOSE)

def remove_lua_indentation(lua_code: str) -> str:
    """
    Removes leading whitespace (indentation) from each line of the Lua script.
    
    Args:
        lua_code (str): The original Lua script as a string.
    
    Returns:
        str: The Lua script with no indentation but with newlines preserved.
    """
    # Split by lines, strip leading spaces/tabs, and rejoin with newline
    lines = lua_code.splitlines()
    stripped_lines = [line.lstrip() for line in lines]
    return "\n".join(stripped_lines)

def analyze_strings(full_code):
    strings = re.findall(STRING_PATTERN, full_code, re.VERBOSE)
    character_used_by_strings = sum(len(s) for s in strings)
    unique_strings = set(strings)
    amount_of_unique = len(unique_strings)
    duplicates = [s for s, count in Counter(strings).items() if count > 1]

    if len(strings) == 0:
        Debug.Note(f"{Debug.GREEN}0{Debug.GREY} characters are used by strings definitions.")
    else:
        percentage = (character_used_by_strings / len(full_code))*100
        Debug.Note(f"{Debug.YELLOW}{character_used_by_strings}{Debug.GREY} ({Debug.YELLOW}{int(percentage)}%{Debug.GREY}) characters are used by defining {Debug.YELLOW}{amount_of_unique}{Debug.GREY} unique strings {Debug.YELLOW}{len(strings)}{Debug.GREY} times.")
        Debug.Note("\t" + str(unique_strings))
        if duplicates:
            Debug.Warning("You have duplicate string definitions! Create a constant to avoid wasting characters like this.")

def analyze_constants(full_code):
    # Cleaning it for the regex to work better.
    cleaned_code = remove_strings_and_comments(full_code)
    constants = re.findall(r'\bc_[a-zA-Z0-9_]*\b', cleaned_code)
    unique_constants = set(constants)
    amount_of_unique_constants = len(unique_constants)
    character_used_by_constants = sum(len(s) for s in constants)

    if len(constants) == 0:
        Debug.Note(f"{Debug.GREEN}0{Debug.GREY} characters are used by constants.")
    else:
        percentage = (character_used_by_constants / len(full_code))*100
        Debug.Note(f"{Debug.YELLOW}{character_used_by_constants}{Debug.GREY} ({Debug.YELLOW}{int(percentage)}%{Debug.GREY}) characters are used by calling {Debug.YELLOW}{amount_of_unique_constants}{Debug.GREY} unique constants {Debug.YELLOW}{len(constants)}{Debug.GREY} times.")
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


def process_file(file_path):
    """Minify a lua file, step by step."""
    
    debug_file_name = os.path.join(*(file_path.split(os.path.sep)[3:]))
    Debug.Info(f"{Debug.MAGENTA}{os.path.basename(file_path)}{Debug.BLUE} : {Debug.GREY}{debug_file_name}")

    # output_lines = [""]
    # line_number = 0
    result = ""

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            Debug.Step("Showing a before...")
            data = f.read()
            character_counter(data)


            Debug.Step("Removing indentation...")
            data = remove_lua_indentation(data)
            result = data

    except FileNotFoundError:
        Error_Line()
        Debug.Error("File not found error.")
        Debug.Note("The path you gave for the file you're trying to require / import does not exist. Validate the full path parsed by the preprocessor.")
        Debug.Error(f"Base name:      {Debug.YELLOW}{os.path.basename(file_path)}")
        Debug.Error(f"Full path:      {Debug.YELLOW}{file_path}")
        Debug.Warning("Process terminating early.")
        Error_Line()
        sys.exit(2)

    # output_lines.append(f"-- [End import: {os.path.relpath(file_path, repo_root)}]\n\n")
    # return ''.join(output_lines)
    return result

def minify_lua(entry_file_path, repo_root):
    """Entrypoint for the Lua minifier."""
    imported_files = set()
    entry_file_path = os.path.normpath(entry_file_path)
    return process_file(entry_file_path)


def full_repository_path():
    """
        Returns the full path to the root of the repository.
        From which you can get the imports working.
    """
    current_working_directory = os.path.dirname(os.path.abspath(__file__))
    # Debug.Info(f"Current working directory; {Debug.GREY}{current_working_directory}")
    root_directory = os.path.normpath(current_working_directory + os.sep + os.pardir)
    # Debug.Info(f"Root directory; {Debug.GREY}{root_directory}")
    return root_directory

def manage_arguments():
    parser = argparse.ArgumentParser(description="Minify a Lua file")
    parser.add_argument("--entry", required=True, help="Path to the entry point Lua file (relative or absolute).")
    parser.add_argument("--output", default="minified.lua", help="Output file path (default: minified.lua)")

    args = parser.parse_args()
    return args

def character_counter(bundled_code):
    Debug.Step("Analyzing character count.")
    amount_of_characters = len(bundled_code)

    color = Debug.GREEN
    if amount_of_characters > 7000:
        color = Debug.YELLOW
    if amount_of_characters > 8192:
        color = Debug.RED

    Debug.Note("===================================")
    Debug.Info(f"Characters used: {color}{amount_of_characters}/8192")
    Debug.Note("===================================")
    analyze_character_usage(bundled_code)
    Debug.Note("===================================")

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
        Debug.Error(f"Root repository: {Debug.GREY}{repository_root}")
        sys.exit(2)
    Debug.Success("Validated")

    output_file = os.path.join(repository_root, arguments.output)
    Debug.Note(f"Output destination: {Debug.GREY}{entry_file}")
    Debug.Note(f"Input target: {Debug.GREY}{entry_file}")

    Debug.NewStep("Minifying code...")
    bundled_code = minify_lua(entry_file, repository_root)

    Debug.NewStep("Saving generated minified code")
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(bundled_code)

    character_counter(bundled_code)

    # print("Bundled file written to bundled_output.lua")
