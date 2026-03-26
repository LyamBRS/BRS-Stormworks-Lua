-- [BRS] - [[ INFORMATIONS ]] -
-- Gets all the composite inputs required for the lua script.

-- [BRS] ------------------------------------------------ [[ BOOLEAN ]] -
carOn                       = input.getBool(c_gbVehicleOn)
seatOccupied                = input.getBool(c_gbDriverSeatOccupancy)
g_passengerSeatOccupancy    = input.getBool(c_gbPassengerSeatOccupancy)
g_blPassengerSeatOccupancy  = input.getBool(c_gbLeftRearPassengerOccupancy)
g_brPassengerSeatOccupancy  = input.getBool(c_gbRightRearPassengerOccupancy)

seatHorn                    = input.getBool(c_gbSeatHorn)
seatHazard                  = input.getBool(c_gbSeatHazards)
seatFlashBeams              = input.getBool(c_gbSeatBeamFlash)
seatCycleBeams              = input.getBool(c_gbSeatBeamCycle)
lightRGB                    = input.getBool(c_gbSeatRGB)

driverDoorPressed[1]        = input.getBool(c_gbDriverDoorButton)
passengerDoorPressed[1]     = input.getBool(c_gbPassengerDoorButton)
hoodPressed[1]              = input.getBool(c_gbHoodButton)
trunkPressed[1]             = input.getBool(c_gbTrunkButton)
closeAllPressed[1]          = input.getBool(c_gbCloseAllButton)

-- [BRS] ------------------------------------------------ [[ NUMERICAL ]] -
velocity                    = tonumber(string.format("%.2f", input.getNumber(c_gnVelocity))) -- Needed due to MP bullshit
angularSpeed                = input.getNumber(c_gnAngularSpeed)

g_playerSensor              = input.getNumber(c_gnPlayerSensor)

seatWS                      = input.getNumber(c_gnSeatWS)
seatAD                      = input.getNumber(c_gnSeatAD)
seatUpDown                  = input.getNumber(c_gnSeatUD)
seatLR                      = input.getNumber(c_gnSeatLR)

BRSynctimeslot              = input.getNumber(c_gnBRSyncTimeSlot)