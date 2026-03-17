-- [BRS] - Gather all the composite inputs of this system.
-- [BRS] - BOOLEAN
g_vehicleOn             = input.getBool(7)
g_blindspotWarningLeft  = input.getBool(8)
g_blindspotWarningRight = input.getBool(9)

-- Lights
g_blinkerLeft       = input.getBool(10)
g_blinkerRight      = input.getBool(11)
g_hazards           = input.getBool(12)
g_interiorLight     = input.getBool(13)
g_DRLs              = input.getBool(14)
g_brakeLights       = input.getBool(15)
g_reverseLights     = input.getBool(16)

g_lowBeams          = input.getBool(17)
g_highBeams         = input.getBool(18)
g_fogLights         = input.getBool(19)

g_honking           = input.getBool(20)
g_slipping          = input.getBool(21)
g_collisionWarning  = input.getBool(22)
g_damaged           = input.getBool(23)

g_doorsLocked       = input.getBool(24)
g_doorsOpened       = input.getBool(25)
g_sosActive         = input.getBool(26)
g_alarmActive       = input.getBool(27)
g_alarmTriggered    = input.getBool(28)

g_playerInSeat      = input.getBool(29)
g_playerSensor      = input.getBool(30)
g_charging          = input.getBool(31)

-- Tick perfect synchronisation of blinking elements for the entire vehicle.
g_universalBlink    = input.getBool(32)

-- [BRS] - NUMERICAL
-- 1 to 17
require("Functions.Physic_sensor.getInputs")

g_lightSetting  = input.getNumber(4) -- Overwrites Euler X

g_temperature   = input.getNumber(18)
g_rain          = input.getNumber(19)
g_humidity      = input.getNumber(20)

g_realSteering = input.getNumber(21)
g_wantedSteering = input.getNumber(22)
g_realThrottle = input.getNumber(23)
g_wantedThrottle = input.getNumber(24)
g_currentGear = input.getNumber(25)

g_driverLookX = input.getNumber(26)
g_driverLookY = input.getNumber(27)

g_battery = input.getNumber(28)
g_batteryUsage = input.getNumber(29)
g_estimatedRange = input.getNumber(30)

-- 31 and 32 for BRIO.