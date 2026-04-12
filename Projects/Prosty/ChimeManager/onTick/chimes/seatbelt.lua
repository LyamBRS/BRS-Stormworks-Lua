-- [BRS] - [[ INFORMATIONS ]] -
-- Manages the seatbelt chimes of the vehicle.
-- According to US laws, it must be on minimum 30 seconds when you're not moving
-- And be endless when you're actually moving.

if g_seatBeltAlarmLevel >= c_seatBeltAlarmLow and not g_playingMusic then
    setNewMusic(g_seatBeltAlarmLevel == c_seatBeltAlarmLow and c_ptMusicSeatBeltSlow or c_ptMusicSeatBeltFast)
    return
end