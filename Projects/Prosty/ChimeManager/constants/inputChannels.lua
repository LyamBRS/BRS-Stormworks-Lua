-- [BRS] - [[ INFORMATIONS ]] -
-- Definition of all the composite input channels required for this Lua script.

-- [BRS] ------------------------------------------------ [[ BOOLEAN ]] -
c_gbVehicleOn           = 32    -- Signals the startup chime to kick on or off
-- c_gbSeatBeltAlarm = 2        -- The seatbelt alarm must go through its process
c_gbAlarm               = 5     -- The vehicle is off and the alarm is ongoing.
c_gbDoorLock            = 6     -- Doors are locked
c_gbDoorButtons         = 7     -- Any door button is pressed.

-- [BRS] ------------------------------------------------ [[ NUMERICAL ]] -
c_gnCurrentGear         = 5     -- Vehicle's current gear.
c_gnSeatBeltAlarmLevel  = 3
c_gnVelocity            = 9     -- meters per seconds, straight from the physic sensor

c_gnDriverDoorPivot     = 10
c_gnPassengerDoorPivot  = 11
c_gnHoodPivot           = 12
c_gnTrunkPivot          = 13