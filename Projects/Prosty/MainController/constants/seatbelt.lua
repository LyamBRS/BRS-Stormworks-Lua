-- [BRS] - [[ INFORMATIONS ]] -
-- The different levels of seatbelt alarms the vehicle can have.

c_seatBeltAlarmOff      = 0 -- Fully turn off the seatbelt alarm
c_seatBeltAlarmConstant = 1 -- Only show the icon on the dash, no beeping, no flashing
c_seatBeltAlarmFlashing = 2 -- Flash the icon, but don't beep anything
c_seatBeltAlarmLow      = 3 -- Slow beeping
c_seatBeltAlarmHigh     = 4 -- Fast paste beeping

c_durationSeatbeltAlarm     = 1800 -- 30 seconds as ticks.
c_seatBeltMinSpeedLowLevel  = 2.7  -- 10kmh, in meters per seconds
c_seatBeltMinSpeedHighLevel = 8.3  -- 30kmh, in meters per seconds