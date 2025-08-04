require("Projects.Prosty.MainController.variables")
-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles the wheels brakes using the driver seat inputs and other various data.
-- ## Where is this used?
-- Prosty main.lua
    if selectedGear == park then
    	brakes = 1
    else
        -- [BRS] - Double tap S should apply the full brakes. Need to do ABS here as well.
    	brakes = -seatWS
    end