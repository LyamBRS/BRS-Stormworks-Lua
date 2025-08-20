import re

def remove_strings_and_comments(code):
    pattern = r"""
        (?:--\[\[.*?\]\])           # multi-line comment
        | (?:--[^\n]*)              # single-line comment
        | (?:"(?:\\.|[^"\\])*")     # double-quoted string
        | (?:'(?:\\.|[^'\\])*')     # single-quoted string
    """
    return re.sub(pattern, '', code, flags=re.DOTALL | re.VERBOSE)

def remove_comments(code):
    pattern = r"""
        (?:--\[\[.*?\]\])           # multi-line comment
        | (?:--[^\n]*)              # single-line comment
    """
    return re.sub(pattern, '', code, flags=re.DOTALL | re.VERBOSE)