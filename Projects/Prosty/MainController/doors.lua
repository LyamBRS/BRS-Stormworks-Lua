require("Projects.Prosty.MainController.variables")
-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles the state the doors should have.
-- ## Where is this used?
-- Prosty main.lua
    -- [BRS] - I could probably make a function to check the pressing arrays... That'd save me some characters?
    if driverDoorPressed[1] ~= driverDoorPressed[2] then
    	driverDoorPressed[2] = driverDoorPressed[1]

		if driverDoorPressed[1] then
	        driverDoorPivot = (driverDoorPivot == 0) and 0.9 or 0
	    end
    end

    if passengerDoorPressed[1] ~= passengerDoorPressed[2] then
    	passengerDoorPressed[2] = passengerDoorPressed[1]

    	if passengerDoorPressed[1] then
    		passengerDoorPivot = (passengerDoorPivot == 0) and 0.9 or 0
    	end
    end

    if trunkPressed[1] ~= trunkPressed[2] then
    	trunkPressed[2] = trunkPressed[1]

    	if trunkPressed[1] then
    		trunkPivot = (trunkPivot == 0) and 0.40 or 0
    	end
    end

    if hoodPressed[1] ~= hoodPressed[2] then
    	hoodPressed[2] = hoodPressed[1]

    	if hoodPressed[1] then
    		hoodPivot = (hoodPivot == 0) and 0.75 or 0
    	end
    end