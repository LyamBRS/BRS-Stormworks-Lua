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

def Error_Line() -> bool:
    Debug.Error(f"{Debug.GREY}===========================================")
    return False

def Error_In(file, at_line):
    Debug.Error(f"Error occured in {Debug.GREY}{file}{Debug.RED} at line {Debug.GREY}{at_line}")