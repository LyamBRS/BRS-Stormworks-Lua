-- [BRS] - [[ INFORMATIONS ]] - 
-- Definition of all the global variables used by the script that are worth defining outside of onTick.
g_previousVehicleOn = false
g_previousSeatbeltAlarm = false

g_currentMusic = {}
g_awaitedMusic = false
g_playingMusic = false

g_seatBeltAlarmLevel = 0
g_seatBeltAlarmTimer = 0

-- [BRS] - Opened access global variables
g_openedAccessLowTimer = 0
g_openedAccessHighTimer = 0
g_openedAccessPreviousGear = 0

g_driverDoorPreviousHolder = {false, false}
g_passengerDoorPreviousHolder = {false, false}
g_hoodPreviousHolder = {false, false}
g_trunkPreviousHolder = {false, false}