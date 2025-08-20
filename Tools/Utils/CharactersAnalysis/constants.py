import re
import sys
from collections import defaultdict
from ..debug import *
from .cleaners import remove_strings_and_comments
#=====================================================#
# region Patterns
#=====================================================#
CONSTANT_PATTERN = r'\bc_[a-zA-Z0-9_]*\b'
#=====================================================#
# region String Getter
#=====================================================#
def get_constants(full_code):
    """
        Returns an array that contains all the data about the constants used in the full code.
        It'll firstly remote strings and comments from the code in order for the search to be
        cleaner.

        Returns:
        ```json
        {
            {
                "name": c_name,
                "contents": [assignation1, assignation2, ...],
                "occurences": amount of times its in the code,
                "assignations": amount of times its declared
            }
        }
        ```
    """
    cleaned_code = remove_strings_and_comments(full_code)
    all_constants = re.findall(CONSTANT_PATTERN, cleaned_code)

    # Pattern to match constant assignments: c_identifier = value
    assign_pattern = re.compile(rf'(?P<name>{CONSTANT_PATTERN})\s*=\s*(?P<value>.+?)(?=\n|;)', re.DOTALL)
    assign_matches = assign_pattern.findall(full_code)

    data = defaultdict(lambda: {
        "name": None,
        "contents": [],
        "occurrences": 0,
        "assignations": 0
    })

    for const in all_constants:
        data[const]["name"] = const
        data[const]["occurrences"] += 1

    for name, value in assign_matches:
        data[name]["name"] = name
        data[name]["contents"].append(value.strip())
        data[name]["assignations"] += 1

    # Normalize to list of dicts
    result = []
    for const_info in data.values():
        entry = {
            "name": const_info["name"],
            "contents": const_info["contents"],
            "occurrences": const_info["occurrences"],
            "assignations": const_info["assignations"]
        }
        result.append(entry)

    return result

#=====================================================#
# region Character count
#=====================================================#
def chars_used_by_constant(constant):
    """
        Tells you how many characters that specific constant takes.
        Pass an entry from `get_constants`
    """
    chars_in_name = len(constant["name"])
    # Calculate the amount of chars used by writing its name.
    chars_used = chars_in_name * constant["occurrences"]

    # Amount of char used by its assignations
    for assignation_index in range(0, constant["assignations"]):
        chars_used += (len(constant["contents"][assignation_index]) + 1)
    return chars_used

def chars_used_by_constants(constants):
    """
        Same as `chars_used_by_constant` but for loops all the constants
        and gives you the result.
    """
    total = 0
    for constant in constants:
        chars_used = chars_used_by_constant(constant)
        total += chars_used
    return total

def constants_used_total_occurences(constants):
    """
        Tells you how many times constants were called in the entire code.
    """
    total = 0
    for constant in constants:
        occurences = constant["occurrences"]
        total += occurences
    return total

#=====================================================#
# region Debugs
#=====================================================#

#=====================================================#
# region Small analyzers
#=====================================================#
def analyze_multiple_assignations(constants):
    """
        Tells you if any constants were assigned multiple times
    """
    constants_with_multiple_assignations = []
    for constant in constants:
        if constant["assignations"] > 1:
            constants_with_multiple_assignations.append(constant)

    amount_assigned_multiple_times = len(constants_with_multiple_assignations)

    if amount_assigned_multiple_times == 0:
        Debug.Success(f"- No constants have multiple assignations")
        return
    
    Debug.Warning(f"- {amount_assigned_multiple_times}{Debug.GREY} constants with multiple assignations!")

def analyze_missing_assignations(constants):
    """
        Tells you if any constants were not assigned any values
    """
    constants_with_missing_assignations = []
    for constant in constants:
        if constant["assignations"] == 0:
            constants_with_missing_assignations.append(constant)

    amount_assigned_0_times = len(constants_with_missing_assignations)

    if amount_assigned_0_times == 0:
        Debug.Success(f"- All constants have assigned values")
        return
    
    Debug.Error(f"- {amount_assigned_0_times}{Debug.GREY} constants with no assignations!")

def analyze_unused_constants(constants):
    """
        Tells you if any constants are declared but not used
    """
    unused_constants = []
    for constant in constants:
        if constant["occurrences"] == 1 and constant["assignations"] == 1:
            unused_constants.append(constant)

    amount_of_unused = len(unused_constants)

    if amount_of_unused == 0:
        Debug.Success(f"- All constants are used")
        return
    
    Debug.Warning(f"- {amount_of_unused}{Debug.GREY} unused constants!")

#=====================================================#
# region Main analyzer
#=====================================================#
def analyze_constants(full_code):
    constants = get_constants(full_code)
    amount_of_unique_constants = len(constants)
    chars_used = chars_used_by_constants(constants)
    total_occurences = constants_used_total_occurences(constants)

    if len(constants) == 0:
        Debug.Note(f"{Debug.GREEN}0{Debug.GREY} characters are used by constants.")
        return 0
    else:
        percentage = (chars_used / len(full_code))*100
        Debug.Note(f"{Debug.MAGENTA}[constants]: {Debug.YELLOW}{chars_used}{Debug.GREY} ({Debug.YELLOW}{int(percentage)}%{Debug.GREY}) characters are used by calling {Debug.YELLOW}{amount_of_unique_constants}{Debug.GREY} unique constants {Debug.YELLOW}{total_occurences}{Debug.GREY} times.")
        analyze_multiple_assignations(constants)
        analyze_missing_assignations(constants)
        analyze_unused_constants(constants)
        Debug.Note("Analysis of all constants:")

        savings = 0
        for constant in constants:
            savings += analyze_constant(constant, chars_used, total_occurences)

        saving_percentage = round((savings / len(full_code))*100,2)
        Debug.Note(f"{Debug.MAGENTA}~{savings}{Debug.BLUE} {Debug.GREY}({Debug.YELLOW}{saving_percentage}%{Debug.GREY}){Debug.BLUE} characters could be saved by manipulating constants")
        return savings

def analyze_constant(constant, total_char_used, total_occurences):
    """
        Prints the constant in the terminal. 
        Will print sub texts if we detect issues like
        - multiple assignations
        - no assignations
        - no usage
        - Can be fully removed

        returns potential savings for this constant.
    """
    name = constant["name"]
    occurences = constant["occurrences"]
    assignations = constant["assignations"]
    contents = constant["contents"]
    chars_used = chars_used_by_constant(constant)

    char_used_percentage = round((chars_used / total_char_used) * 100,2)

    Debug.Note(f"\t{Debug.BLUE}{name}{Debug.GREY}, used {Debug.BLUE}{occurences}{Debug.GREY} times using {Debug.YELLOW}{chars_used}{Debug.GREY} characters ({Debug.YELLOW}{char_used_percentage}%{Debug.GREY} of constants) was assigned {Debug.BLUE}{assignations}{Debug.GREY} times with: {contents}")
    
    # You're either redefining an existing constant or using them as variables. No should do bro.
    if assignations > 1:
        chars_to_save = 0
        for content_index in range(1, assignations):
            assignation = contents[content_index]
            chars_to_save += (len(name) + 1 + len(assignation))
        Debug.Warning(f"\t\tMultiple assignations! {Debug.MAGENTA}~{chars_to_save}{Debug.GREY} characters could be saved by fixing this.")
        return chars_to_save

    # You're using a constant but we could'nt detect any declaration of it... Probably a missing require somewhere.
    elif assignations == 0:
        Debug.Error("\t\tUndefined constant! No assignations were found.")
        Error_Line()
        Debug.Error("Fix your code. It would not compile without this constant being declared!")
        Error_Line()
        sys.exit(2)

    # The constant is only used once. It's thus unused
    elif occurences == 1:
        # You could remove its entirety
        chars_to_save = 1 + len(name) + len(contents[0])
        Debug.Note(f"\t\t{Debug.YELLOW}Unused constant!{Debug.GREY} Removing it would save {Debug.MAGENTA}~{chars_to_save}{Debug.GREY} characters")
        return chars_to_save
    
    # The constant is used twice. This means it was initialized but used only in one place. It can thus be removed.
    elif occurences == 2:
        # You could remove its entirety
        chars_to_save = 1 + len(name) * 2
        Debug.Note(f"\t\t{Debug.YELLOW}Only one usage!{Debug.GREY} Removing it would save {Debug.MAGENTA}~{chars_to_save}{Debug.GREY} characters")
        return chars_to_save

    # The assignation is only 1 character. The whole constant could be removed to save some characters.
    elif len(contents[0]) == 1:
        chars_to_save = 0
        # Counting the declaration: =N
        chars_to_save += 2
        # All instances of the name:
        chars_to_save += len(name) * occurences
        Debug.Note(f"\t\t{Debug.YELLOW}1 char contents!{Debug.GREY} Replacing all occurences would save {Debug.MAGENTA}~{chars_to_save}{Debug.GREY} characters")
        return chars_to_save
    
    else:
        size_of_contents = len(contents[0])
        current_char_usage = 1 + occurences * len(name) + size_of_contents
        char_usage_if_full_minified = 1 + occurences * 1 + size_of_contents
        usage_if_not_there = (occurences - 1) * size_of_contents

        # Even if the constant is replaced with a single letter variable, using it would still use more characters than using the bare values
        if usage_if_not_there < char_usage_if_full_minified:
            chars_to_save = current_char_usage - usage_if_not_there
            saving_when_minified = char_usage_if_full_minified - usage_if_not_there
            Debug.Note(f"\t\t{Debug.YELLOW}Uses more chars even when minified.{Debug.GREY} Replacing all occurences would save {Debug.MAGENTA}~{chars_to_save}{Debug.GREY} characters, ({Debug.MAGENTA}~{saving_when_minified}{Debug.GREY} minified)")
            return chars_to_save

        # Not using the constant only saves characters in unminified code.
        elif usage_if_not_there < current_char_usage:
            chars_to_save = current_char_usage - usage_if_not_there
            costs_to_remove = usage_if_not_there - char_usage_if_full_minified
            Debug.Note(f"\t\t{Debug.YELLOW}Saves chars only when minified.{Debug.GREY} Replacing all would save {Debug.MAGENTA}~{chars_to_save}{Debug.GREY} characters but cost {Debug.RED}~{costs_to_remove}{Debug.GREY} when minified")
            return chars_to_save
        else:
            # Using this constant saves characters in all cases.
            return 0
    return 0