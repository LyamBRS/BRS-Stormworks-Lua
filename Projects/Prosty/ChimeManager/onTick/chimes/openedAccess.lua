-- [BRS] - [[ INFORMATIONS ]] -
-- Manages the access opened chimes. 
-- This has a lesser priority than the seatbelt alarm

if (g_playHighAccessChime or g_playLowAccessChime) and not g_playingMusic then
    setNewMusic(g_playHighAccessChime and c_ptMusicDoorOpenedHigh or c_ptMusicDoorOpenedLow, false)
end