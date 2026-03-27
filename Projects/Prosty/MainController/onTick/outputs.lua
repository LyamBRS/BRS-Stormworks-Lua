    output.setBool(c_sbBrakeLight, brakeLight)
    output.setBool(c_sbTailights, tailight)
    output.setBool(c_sbReverseLights, reverseLight)
    output.setBool(c_sbSpotlights, spotlight)
    output.setBool(c_sbBlinkersBlinking, (BRSynctimeslot+4)%(45+1) > 29) -- blinking of blinkers
    output.setBool(c_sbRightBlinker, selectedBlinker == blinkRight or selectedBlinker == blinkBoth)
    output.setBool(c_sbLeftBlinker, selectedBlinker == blinkLeft or selectedBlinker == blinkBoth)
    output.setBool(c_sbRGBLights, lightRGB)
    output.setBool(c_sbHazards, selectedBlinker == blinkBoth)
    output.setBool(c_sbCarOn, carOn)

    -- [BRS] - spotlight
    output.setNumber(c_snSpotlightTiltRight, spotlightTiltRight)
    output.setNumber(c_snSpotlightTiltLeft, spotlightTiltLeft)
    output.setNumber(c_snSpotlightYawRight, spotlightYawRight)
    output.setNumber(c_snSpotlightYawLeft, spotlightYawLeft)

    -- [BRS] - vehicle pivots
    output.setNumber(c_snDriverDoorPivot, g_driverPivot)
    output.setNumber(c_snPassengerDoorPivot, g_passengerPivot)
	output.setNumber(c_snHoodPivot, g_hoodPivot)
	output.setNumber(c_snTrunkPivot, g_trunkPivot)

    -- [BRS] - vehicle driving
    output.setNumber(c_snThrottleFR, throttle)
    output.setNumber(c_snThrottleFL, throttle)
    output.setNumber(c_snThrottleBR, throttle)
    output.setNumber(c_snThrottleBL, throttle)
    output.setNumber(c_snSteeringLeft, steeringLeft)
    output.setNumber(c_snSteeringRight, steeringRight)
    output.setNumber(c_snVariableBrakes, brakes)
    output.setNumber(c_snSelectedGear, selectedGear)

    -- [BRS] - vehicle alarms
    output.setNumber(c_snSeatBeltAlarmLevel, g_seatBeltAlarmLevel)