-- [BRS] - Gather all the composite inputs of this system.
-- [BRS] - BOOLEAN
g_vehicleOn = input.getBool(7)
g_blindspotWarningLeft = input.getBool(8)
g_blindspotWarningRight = input.getBool(9)

-- Lights
g_blinkerLeft = input.getBool(10)
g_blinkerRight = input.getBool(11)
g_hazards = input.getBool(12)
g_interiorLight = input.getBool(13)
g_DRLs = input.getBool(14)
g_brakeLights = input.getBool(15)
g_reverseLights = input.getBool(16)

g_lowBeams = input.getBool(17)
g_highBeams = input.getBool(18)
g_fogLights = input.getBool(19)

g_honking = input.getBool(20)
g_slipping = input.getBool(21)
g_collisionWarning = input.getBool(22)
g_damaged = input.getBool(23)

g_doorsLocked = input.getBool(24)
g_doorsOpened = input.getBool(25)
g_sosActive = input.getBool(26)
g_alarmActive = input.getBool(27)
g_alarmTriggered = input.getBool(28)

g_playerInSeat = input.getBool(29)
g_playerNear = input.getBool(30)

-- Tick perfect synchronisation of blinking elements for the entire vehicle.
g_universalBlink = input.getBool(32)

-- [BRS] - NUMERICAL
-- Physic sensor
g_vehiclePositionX = input.getNumber(1)
g_vehiclePositionY = input.getNumber(2)
g_vehiclePositionZ = input.getNumber(3)
g_vehicleEulerX = input.getNumber(4)
g_vehicleEulerY = input.getNumber(5)
g_vehicleEulerZ = input.getNumber(6)
g_vehicleLinearX = input.getNumber(4)
g_vehicleLinearY = input.getNumber(5)
g_vehicleLinearZ = input.getNumber(6)