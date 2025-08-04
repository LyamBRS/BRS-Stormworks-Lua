require("Projects.Prosty.MainController.variables")
-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles the spotlights status and tilt based on various modes of the beams as well as seat stuff.
-- ## Where is this used?
-- Prosty main.lua
    if outputBeam == high or outputBeam == low then
    	spotlight = true
    	wantedLeftTilt = lowTilt
    	wantedRightTilt = lowTilt
    	wantedRightYaw = lowYaw
    	wantedLeftYaw = lowYaw

    	if outputBeam == high then
    		wantedLeftTilt = highTilt
    		wantedRightTilt = highTilt
	    	wantedRightYaw = highYaw
			wantedLeftYaw = highYaw
    	end
    else
    	spotlight = false
    	wantedLeftTilt = lowTilt
    	wantedRightTilt = lowTilt
    	wantedLeftYaw = lowYaw
    	wantedRightYaw = lowYaw
    end

    -- [BRS] - Management to ensure indication visibility with high beams.
    if selectedBlinker == blinkRight then
    	wantedRightTilt = lowTilt
    	-- wantedRightYaw = lowYaw
    end

    if selectedBlinker == blinkLeft then
    	wantedLeftTilt = lowTilt
    	-- wantedLeftYaw = lowYaw
    end

    -- [BRS] - Sets the actual output variables to the wanted ones. This allows distinction between what we're outputing and the wanted behaviors.
    spotlightTiltRight = wantedRightTilt
    spotlightTiltLeft = wantedLeftTilt
    spotlightYawLeft = wantedLeftYaw
    spotlightYawRight = wantedRightYaw