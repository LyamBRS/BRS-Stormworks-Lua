require("Projects.Prosty.MainController.variables")
-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles how the throttle should be applied to the motors.
-- ## Where is this used?
-- Prosty main.lua
    -- [BRS] - Probably can check for seatWS as a nested IF.
    if selectedGear == drive and seatWS >= 0 then
    	throttle = seatWS
    elseif selectedGear == reverse and seatWS >= 0 then
    	throttle = -seatWS
    else
        -- [BRS] - Throttle isn't used anywhere, so this could be above the if to save some characters.
    	throttle = 0
    end