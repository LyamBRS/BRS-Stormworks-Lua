-- [BRS] - [[ INFORMATIONS ]] -
-- Manages the seatbelt alarm outside of music player functionalities
-- keeps track of time.

if g_seatBeltAlarm then
    if g_gear ~= 0 then
        -- high seatbelt must be played
        g_seatBeltAlarmLevel = c_seatBeltAlarmHigh
        g_seatBeltAlarmTimer = c_durationSeatbeltAlarm
    else
        if g_seatBeltAlarmTimer > 0 then
            g_seatBeltAlarmLevel = c_seatBeltAlarmLow
            g_seatBeltAlarmTimer = g_seatBeltAlarmTimer - 1
        else
            g_seatBeltAlarmLevel = c_seatBeltAlarmOff
        end
    end
else
    g_seatBeltAlarmLevel = c_seatBeltAlarmOff
    g_seatBeltAlarmTimer = c_durationSeatbeltAlarm
end