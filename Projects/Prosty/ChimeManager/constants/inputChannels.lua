-- [BRS] - [[ INFORMATIONS ]] -
-- Definition of all the composite input channels required for this Lua script.

-- [BRS] ------------------------------------------------ [[ BOOLEAN ]] -
c_gbVehicleOn = 1       -- Signals the startup chime to kick on or off
c_gbSeatBeltAlarm = 2   -- The seatbelt alarm must go through its process
c_gbDoorOpened = 3      -- Any door is opened, excluding trunk and hood.
c_gbAlarm = 5           -- The vehicle is off and the alarm is ongoing.
c_gbDoorLock = 6        -- Doors are locked
c_gbDoorButtons = 7     -- Any door button is pressed.

-- [BRS] ------------------------------------------------ [[ NUMERICAL ]] -
c_gnCurrentGear = 25    -- Vehicle's current gear.