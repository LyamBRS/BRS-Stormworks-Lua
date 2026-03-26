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

if g_playerSensor > seatedPlayers and carOn then
    if selectedGear ~= park then
        if velocity > c_seatBeltMinSpeedHighLevel then
            g_seatBeltAlarmLevel = c_seatBeltAlarmHigh
            g_seatBeltAlarmTimer = c_durationSeatbeltAlarm
        elseif velocity > c_seatBeltMinSpeedLowLevel and g_seatBeltAlarmTimer>0 then
            g_seatBeltAlarmLevel = c_seatBeltAlarmLow
            countDown = true
        else
            countDown = true
            g_seatBeltAlarmLevel = c_seatBeltAlarmFlashing
        end
    else
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