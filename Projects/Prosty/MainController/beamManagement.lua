-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles the beam the car should be in.
-- Also manages beam flashing.
-- ## Where is this used?
-- Prosty main.lua

	-- [BRS] - If the car is on, the lights can't be off.
	if carOn and selectedBeam == c_lightSettingOff then
		selectedBeam = c_lightSettingDRL
	end

    -- [BRS] - Has an issue where it doesn't begin in the right beam the first time.
    -- [BRS] - Seats presses management.
    if seatCycleBeams ~= previousSeatCycleBeams then
    	previousSeatCycleBeams = seatCycleBeams

        -- [BRS] - Beams only change if the car is ON... idk if that's the best thing tbh. If they are left on it should have an alarm instead.
    	if seatCycleBeams and carOn then
    		selectedBeam = selectedBeam + 1
	    	if selectedBeam > c_lightSettingHighBeams then
    			selectedBeam = c_lightSettingDRL
			end
    	end
    end

	-- [BRS] - Automatic lights management
	if selectedBeam == c_lightSettingAutomatic then
		outputBeam = c_lightSettingDRL
		if g_clock < c_clockDayTime or g_clock > c_clockNightTime then -- Night time
			outputBeam = c_lightSettingLowBeams
		else
			if g_topDistanceSensor < c_distanceTunnelDetection and g_upsideDownRatio < c_ratioOnTheSide then
				outputBeam = c_lightSettingLowBeams
			end
		end
	end

	if not carOn then
		-- [BRS] - Lights are off if the car is off
		selectedBeam = c_lightSettingOff
	elseif seatFlashBeams then
		-- [BRS] - Flashing your beams work differently if you're in automatic mode or not
		if selectedBeam == c_lightSettingAutomatic then
			outputBeam = outputBeam == c_lightSettingHighBeams and c_lightSettingLowBeams or c_lightSettingHighBeams
		else
			outputBeam = selectedBeam == c_lightSettingHighBeams and c_lightSettingLowBeams or c_lightSettingHighBeams
		end
	elseif selectedBeam ~= c_lightSettingAutomatic then
		outputBeam = selectedBeam
	end