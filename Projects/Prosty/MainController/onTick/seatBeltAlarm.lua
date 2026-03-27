-- [BRS] - [[ INFORMATIONS ]] -
-- Manages the seatbelt alarm's triggering.
-- For the seatbelt to trigger:
-- - Vehicle must be on
-- - there has to be more players detected than seated players

-- [BRS] - Counting the seated players
seatedPlayers = 0
seatedPlayers = seatOccupied                and (seatedPlayers+1) or seatedPlayers
seatedPlayers = g_passengerSeatOccupancy    and (seatedPlayers+1) or seatedPlayers
seatedPlayers = g_blPassengerSeatOccupancy  and (seatedPlayers+1) or seatedPlayers
seatedPlayers = g_brPassengerSeatOccupancy  and (seatedPlayers+1) or seatedPlayers

-- [BRS] - Comparing with detected amount of seated players
g_seatBeltAlarmLevel = c_seatBeltAlarmOff
countDown = false

-- [BRS] - Seatbelt alarm is only active when there's more detected players than seated one
-- and the car is on.
if g_playerSensor > seatedPlayers and carOn then

    -- [BRS] - Not being in park requires more indepth seatbelt alarms
    if selectedGear ~= c_gearPark then
        -- [BRS] - Velocity exeeds some set speed, really remind them they aint wearing it.
        if velocity > c_seatBeltMinSpeedHighLevel then
            g_seatBeltAlarmLevel = c_seatBeltAlarmHigh
            g_seatBeltAlarmTimer = c_durationSeatbeltAlarm
        -- [BRS] - Below a certain speed, seatbelt alarm can shut off after a while
        elseif velocity > c_seatBeltMinSpeedLowLevel and g_seatBeltAlarmTimer>0 then
            g_seatBeltAlarmLevel = c_seatBeltAlarmLow
            countDown = true
        else
            countDown = true
            g_seatBeltAlarmLevel = c_seatBeltAlarmFlashing
        end
    else
        -- [BRS] - When you're in park, just make the icon constant. No sound.
        g_seatBeltAlarmLevel = c_seatBeltAlarmConstant
    end
else
    g_seatBeltAlarmLevel = c_seatBeltAlarmOff
end

-- [BRS] - Regulated minimum amount of time we gotta play the seatbelt sound.
if countDown then
    g_seatBeltAlarmTimer = g_seatBeltAlarmTimer - 1
else
    g_seatBeltAlarmTimer = c_durationSeatbeltAlarm
end