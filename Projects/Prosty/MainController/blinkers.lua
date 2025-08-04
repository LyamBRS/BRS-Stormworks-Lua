require("Projects.Prosty.MainController.variables")
-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles what makes the blinkers turn on or off.
-- ## Where is this used?
-- Prosty main.lua
--
    -- [BRS] - Hazards management. From the driver seat.
    if seatHazard ~= previousHazards then
    	previousHazards = seatHazard
    	if seatHazard then
    		if selectedBlinker == blinkBoth then
    			selectedBlinker = off
    		else
    			selectedBlinker = blinkBoth
    		end
    	end
    end

    -- [BRS] - Driver seat L/R controls. Manages selected blinker.
    -- [BRS] - ternary operators could probably be used here.
    if seatLR ~= previousLR then
    	previousLR = seatLR

    	if seatLR == 1 then
    		if selectedBlinker == blinkRight then
    			selectedBlinker = off
    		else
    			selectedBlinker = blinkRight
    		end
    	end

    	if seatLR == -1 then
    		if selectedBlinker == blinkLeft then
    			selectedBlinker = off
    		else
    			selectedBlinker = blinkLeft
    		end
    	end
    end