from .constants import analyze_constants
from .strings_analysis import analyze_strings
from ..debug import *

def analyze_character_usage(full_code):
    """
        Calls all the other analyzers, one by one.
    """
    savings = 0
    savings += analyze_constants(full_code)
    savings += analyze_strings(full_code)

    saving_percentage = round((savings / len(full_code))*100,2)
    Error_Line()
    Debug.Note(f"{Debug.MAGENTA}~{savings}{Debug.BLUE} {Debug.GREY}({Debug.YELLOW}{saving_percentage}%{Debug.GREY}){Debug.BLUE} characters could be saved with manipulations")
    Error_Line()