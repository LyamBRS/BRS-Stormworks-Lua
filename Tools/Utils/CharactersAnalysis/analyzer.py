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