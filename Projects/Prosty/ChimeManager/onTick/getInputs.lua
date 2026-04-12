-- [BRS] - [[ INFORMATIONS ]] -
-- Gets all the composite inputs required for the lua script.

-- [BRS] ------------------------------------------------ [[ BOOLEAN ]] -
g_vehicleOn     = input.getBool(c_gbVehicleOn)
-- g_seatBeltAlarm = input.getBool(c_gbSeatBeltAlarm)
-- g_doorOpened    = input.getBool(c_gbDoorOpened)
g_alarm         = input.getBool(c_gbAlarm)
g_doorLock      = input.getBool(c_gbDoorLock)
g_doorPressed   = input.getBool(c_gbDoorButtons)

-- [BRS] ------------------------------------------------ [[ NUMERICAL ]] -
g_gear                  = input.getNumber(c_gnCurrentGear)
g_seatBeltAlarmLevel    = input.getNumber(c_gnSeatBeltAlarmLevel)
g_velocity              = input.getNumber(c_gnVelocity)

g_driverPivot           = input.getNumber(c_gnDriverDoorPivot)
g_passengerPivot        = input.getNumber(c_gnPassengerDoorPivot)
g_hoodPivot             = input.getNumber(c_gnHoodPivot)
g_trunkPivot            = input.getNumber(c_gnTrunkPivot)