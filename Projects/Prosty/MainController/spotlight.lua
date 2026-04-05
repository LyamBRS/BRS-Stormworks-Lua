-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles the spotlights status and tilt based on various modes of the beams as well as seat stuff.
-- ## Where is this used?
-- Prosty main.lua

-- [BRS] - Low / high beams management
if outputBeam == c_lightSettingHighBeams or outputBeam == c_lightSettingLowBeams then
	spotlight = true

	-- [BRS] - Fog low beam tilt calculations
	-- Makes your low beams dip even more if theres' fog, up to a certain point
	fogTiltAdjustments = math.min(1, g_humidity/c_lowbeamMaxFog) * c_lowbeamMaxFogTiltAdjustment

	wantedLeftTilt 	= c_lowbeamTilt - fogTiltAdjustments
	wantedRightTilt = c_lowbeamTilt - fogTiltAdjustments
	wantedRightYaw 	= c_lowbeamYaw
	wantedLeftYaw 	= c_lowbeamYaw

	if outputBeam == c_lightSettingHighBeams then
		wantedLeftTilt = c_highbeamTilt
		wantedRightTilt = c_highbeamTilt
		wantedRightYaw = c_highbeamYaw
		wantedLeftYaw = c_highbeamYaw
	end
else
	spotlight = false
	wantedLeftTilt = c_lowbeamTilt
	wantedRightTilt = c_lowbeamTilt
	wantedLeftYaw = c_lowbeamYaw
	wantedRightYaw = c_lowbeamYaw
end

-- [BRS] - Management to ensure indication visibility with high beams.
if selectedBlinker == blinkRight then
	wantedRightTilt = c_lowbeamTilt
	-- wantedRightYaw = lowYaw
end

if selectedBlinker == blinkLeft then
	wantedLeftTilt = c_lowbeamTilt
	-- wantedLeftYaw = lowYaw
end

-- [BRS] - Sets the actual output variables to the wanted ones. This allows distinction between what we're outputing and the wanted behaviors.
spotlightTiltRight = wantedRightTilt
spotlightTiltLeft = wantedLeftTilt
spotlightYawLeft = wantedLeftYaw
spotlightYawRight = wantedRightYaw