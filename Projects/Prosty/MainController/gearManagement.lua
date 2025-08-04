require("Projects.Prosty.MainController.variables")
-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles the gears shifting through the driver seat inputs and other various data.
-- ## Where is this used?
-- Prosty main.lua
    if not seatOccupied then
        -- [BRS] - Needs to be changed so if in neutral, the gears stays in neutral.
    	selectedGear = park
    else
        -- [BRS] - This should be checking if the car is ON or not.
    	-- Shift detection
    	if seatUpDown ~= previousUpDown then -- the up/down arrows values 
    		previousUpDown = seatUpDown

    		if seatUpDown > 0 and selectedGear < drive then
    			selectedGear = selectedGear + 1
    		end

    		if seatUpDown < 0 and selectedGear > reverse then
    			selectedGear = selectedGear - 1
    		end
    	end
    end