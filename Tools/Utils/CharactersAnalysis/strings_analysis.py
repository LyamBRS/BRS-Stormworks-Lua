import re
from collections import Counter
from collections import defaultdict
from .cleaners import remove_comments
from ..debug import *

#=====================================================#
# region Patterns
#=====================================================#
STRING_PATTERN = r'''
(?:
    " (?:\\.|[^"\\])* "    # double-quoted strings
  | ' (?:\\.|[^'\\])* '    # single-quoted strings
)
'''
#=====================================================#
# region String Getter
#=====================================================#
def get_strings(full_code):
    """
        Analyses the full code and returns an array of analyzed strings.

        Returns:
        ```json
        {
            {
                "contents": "blablabla",
                "occurrences": how many times that string is found in the code,
                "assignations": how many times that string is assigned raw to a variable
            }
        }
        ```
    """
    # To avoid matching strings that are commented
    uncommented_code = remove_comments(full_code)

    # Find all string literals
    string_matches = re.findall(STRING_PATTERN, uncommented_code, flags=re.VERBOSE)

    # Clean quotes from string values
    def unquote(s):
        return s[1:-1] if len(s) >= 2 else s

    string_counts = defaultdict(lambda: {
        "contents": "",
        "occurrences": 0,
        "assignations": 0
    })

    for s in string_matches:
        unquoted = unquote(s)
        string_counts[unquoted]["contents"] = unquoted
        string_counts[unquoted]["occurrences"] += 1

    # Check for assignments like: var = "string"
    assignment_pattern = re.compile(rf'\b\w+\s*=\s*({STRING_PATTERN})', flags=re.VERBOSE)
    assign_matches = assignment_pattern.findall(uncommented_code)

    for match in assign_matches:
        string_value = unquote(match[0])
        if string_value in string_counts:
            string_counts[string_value]["assignations"] += 1

    return list(string_counts.values())

#=====================================================#
# region Character count
#=====================================================#
def chars_used_by_strings(strings):
    """
        tells you how many characters are being used by strings.
    """
    if len(strings) == 0:
        return 0
    
    chars_used = 0
    for string in strings:
        chars_used += ((len(string["contents"]) + 2) * string["occurrences"])
    return chars_used

def chars_used_by_string(string):
    """
        tells you how many characters are being used by strings.
    """    
    return (len(string["contents"]) + 2) * string["occurrences"]

def amount_of_duplicate_strings(strings):
    if len(strings) == 0:
        return 0
    
    duplicates = 0
    for string in strings:
        if string["occurrences"] > 1:
            duplicates += 1
    return duplicates

def amount_of_string_occurences(strings):
    if len(strings) == 0:
        return 0
    
    total = 0
    for string in strings:
        total += string["occurrences"]
    return total

#=====================================================#
# region Small analyzers
#=====================================================#
def analyze_duplicates(strings):
    """
        Tells you if any strings are found multiple times in the code
    """
    duplicates = amount_of_duplicate_strings(strings)

    if duplicates == 0:
        Debug.Success(f"- There's no duplicate strings")
        return
    
    Debug.Warning(f"- {duplicates}{Debug.GREY} strings have 1 or more duplicates")


#=====================================================#
# region Analysis
#=====================================================#
def analyze_string(string, total_char_used):
    occurences = string["occurrences"]
    assignations = string["assignations"]
    content = string["contents"]
    chars_used = chars_used_by_string(string)

    char_used_percentage = round((chars_used / total_char_used) * 100,2)

    Debug.Note(f"\t{Debug.BLUE}\"{content}\"{Debug.GREY}, found {Debug.BLUE}{occurences}{Debug.GREY} times uses {Debug.YELLOW}{chars_used}{Debug.GREY} characters ({Debug.YELLOW}{char_used_percentage}%{Debug.GREY} of strings) was assigned {Debug.BLUE}{assignations}{Debug.GREY} times")
    
    # You have duplicate strings!
    if occurences > 1:
        # You could save n-1 amount of string definitions...
        chars_to_save = ((len(content) + 2) * (occurences-1))
        # Creating the variable that holds that string would cost 2 characters if its a single letter.
        chars_to_save -= 2
        # Every call to the string cost 1 character
        chars_to_save -= occurences

        if chars_to_save > 0:
            Debug.Note(f"\t\t{Debug.YELLOW}Dupplicates!{Debug.GREY} Having a global minified variable of 1 char would save {Debug.GREEN}~{chars_to_save}{Debug.GREY} characters")
        elif chars_to_save == 0:
            Debug.Note(f"\t\t{Debug.YELLOW}Dupplicates!{Debug.GREY} No characters would be saved with a global minified variable of 1 char")
        else:
            Debug.Note(f"\t\t{Debug.YELLOW}Dupplicates!{Debug.GREY} Minifying would cost characters: {Debug.RED}~{-chars_to_save}")
            chars_to_save = 0

        return chars_to_save
    
    return 0

def analyze_strings(full_code):
    strings = get_strings(full_code)
    character_used_by_strings = chars_used_by_strings(strings)
    amount_of_unique = len(strings)
    amount_of_duplicates = amount_of_duplicate_strings(strings)
    amount_of_occurences = amount_of_string_occurences(strings)

    if len(strings) == 0:
        Debug.Note(f"{Debug.GREEN}0{Debug.GREY} characters are used by strings definitions.")
        return 0
    else:
        percentage = round((character_used_by_strings / len(full_code))*100,2)
        Debug.Note(f"{Debug.MAGENTA}[strings]: {Debug.YELLOW}{character_used_by_strings}{Debug.GREY} ({Debug.YELLOW}{percentage}%{Debug.GREY}) characters are used by calling {Debug.YELLOW}{amount_of_unique}{Debug.GREY} unique strings {Debug.YELLOW}{amount_of_occurences}{Debug.GREY} times.")
        analyze_duplicates(strings)

        savings = 0
        for string in strings:
            savings += analyze_string(string, character_used_by_strings)
        saving_percentage = round((savings / len(full_code))*100,2)
        Debug.Note(f"{Debug.MAGENTA}~{savings}{Debug.BLUE} {Debug.GREY}({Debug.YELLOW}{saving_percentage}%{Debug.GREY}){Debug.BLUE} characters could be saved by manipulating strings")
        return savings