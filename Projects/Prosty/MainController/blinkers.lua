require("Projects.Prosty.MainController.variables")
-- [BRS] - [[ Information ]] --
-- `25/09/09`
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

		-- [BRS] - Executes only when the driver seat's left and right arrow value changed to be pressed.
    	if seatLR ~= 0 then
			-- [BRS] If the player is pressing right, it wants to perform actions for a right blinker, otherwise its automatically associated with the left one.
			-- [BRS] That's because at this point you're sure the arrow key are pressed.
    		wanted = seatLR > 0 and blinkRight or blinkLeft

			-- [BRS] - If the current blinker is the same as the one wanted by the arrow key,
			-- [BRS] - It means that the player pressed the same arrow associated with the ongoing blinker... it must thus be turned off.
			-- [BRS] - Otherwise, it means that the wanted blinker isnt the same as the current one, it should thus update to that one.
    		selectedBlinker = selectedBlinker == wanted and off or wanted
    	end
    end