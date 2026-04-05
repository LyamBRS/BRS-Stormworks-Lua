-- [BRS] - [[ INFORMATIONS ]] - 
-- Settings related to the spotlights of the vehicle
-- How low they should tilt or how high, values for low and high beams
-- And any other settings related to spotlights

-- [BRS] - Static values during normal operations
c_highbeamTilt      = 0     -- Pitch of the spotlights when you're in high beams
c_lowbeamTilt       = -.7   -- Pitch of the spotlights when you're in low beams, no fog
c_highbeamYaw       = .5    -- Left / right yaw of the spotlights in high beams, messes with their FOV
c_lowbeamYaw        = -.25  -- Left / right yaw of the spotlights in low beams, messes with their FOV

-- [BRS] - Weather influenced spotlight tilts
c_lowbeamMaxFogTiltAdjustment = .06  -- At a defined maximum humidity, How much further down should the spotlight aim
c_lowbeamMaxFog               = .6  -- At this humidity level, the low beam tilts will be equal to the constant above