require("Projects.Prosty.MainController.variables")
-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles the beam the car should be in.
-- Manages what makes the brake lights turn on.
-- ## Where is this used?
-- Prosty main.lua
----------------- Brake lights
    -- [BRS] - timeAbove is not used at all? How does it even function then??
    if velocity ~= oldVelocity then
    	delta = velocity - oldVelocity
    	oldVelocity = velocity
    end

    -- [BRS] - brake lights should still work if the car is off.
    if not carOn then
    	brakeLight = false
    	delta = 0
    	oldVelocity = velocity
    	checkStage = 0
    	timeAbove = 0
    else
    	if checkStage == 0 then
    		brakeLight = false
    	end

        -- [BRS] - Player is actively pressing the brakes here.
    	if seatWS < 0 then
    		brakeLight = true
            -- [BRS] - They are pressing the brakes but also moving fast.
    		if velocity > 2 then
                -- [BRS] - Stage 1 ensures that the velocity gets checked for a bit.
	    		checkStage = 1
	    	else
                -- [BRS] - Not moving fast enough. The brake lights must be identical to the seat's inputs.
	    		checkStage = 0
	    	end
    		timeAbove = 0
    	end

    	if delta < -.2 and checkStage == 1 or checkStage == 2 then
    		brakeLight = true
    		checkStage = 2
    	end

    	if delta > -.2 and checkStage == 2 then
			brakeLight = false
    		checkStage = 0
    	end

    	if seatWS > 0.01 then
    		checkStage = 0
    		brakeLight = false
    		timeAbove = 0
    	end
    end