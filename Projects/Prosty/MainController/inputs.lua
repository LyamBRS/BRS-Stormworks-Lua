	
    -- [BRS] - Vehicles in.
    carOn = input.getBool(7)

	-- [BRS] - Physic sensor
	velocity = tonumber(string.format("%.2f", input.getNumber(13))) -- Needed due to MP bullshit

    -- [BRS] Seat
    seatOccupied = input.getBool(32)
    seatWS = input.getNumber(2)
    seatAD = input.getNumber(1)
    seatUpDown = input.getNumber(4)
    seatLR = input.getNumber(3)

    seatHorn = input.getBool(1)
	seatHazard = input.getBool(2)
    seatFlashBeams = input.getBool(3)
    seatCycleBeams = input.getBool(4)

    -- [BRS] BRSync
    BRSynctimeslot = input.getNumber(32)

    -- [BRS] Instrument panels
    driverDoorPressed[1] = input.getBool(8)
    passengerDoorPressed[1] = input.getBool(9)
    hoodPressed[1] = input.getBool(10)
    trunkPressed[1] = input.getBool(11)
    closeAllPressed[1] = input.getBool(11)