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
		selectedBeam = c_lightSettingAutomatic -- TODO: Make it a constant to allow users to select what the default beam should be
	end

	-- [BRS] - You need to be going the minimum speed for a bit before the high beams can turn on.
	--       - Without this, if you spin in circles, it can jitter on / off
	if velocity > c_lightAutoHighMinSpeed then
		g_highBeamSpeedTimer = g_highBeamSpeedTimer - 1
	else
		g_highBeamSpeedTimer = c_lightAutoHighSpeedDuration
	end

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

		-- [BRS] - Night time
		if g_clock < c_clockDayTime or g_clock > c_clockNightTime then
			outputBeam = c_lightSettingLowBeams

			-- [BRS] - Automatic high beam management
			if g_clock < c_clockDayTimeHigh or g_clock > c_clockNightTimeHigh then
				if g_noCarInFrontOfHighBeams and g_highBeamSpeedTimer < 0 and g_humidity < c_lightAutoHighMaxFog and g_rain < c_lightAutoHighMaxRain then
					outputBeam = c_lightSettingHighBeams
				end
			end
		else
			-- [BRS] - Tunnel detection
			if g_topDistanceSensor < c_distanceTunnelDetection and g_upsideDownRatio < c_ratioOnTheSide then
				outputBeam = c_lightSettingLowBeams
			end

			-- [BRS] - Weather condition detections
			if g_rain > c_lightAutoLowMinRain or g_humidity > c_lightAutoLowMinFog then
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