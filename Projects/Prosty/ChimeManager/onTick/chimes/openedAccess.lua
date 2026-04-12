-- [BRS] - [[ INFORMATIONS ]] -
-- Manages the access opened chimes. 
-- This has a lesser priority than the seatbelt alarm

if (g_playHighAccessChime or g_playLowAccessChime) and not g_playingMusic then
    setNewMusic(g_playHighAccessChime and c_ptMusicDoorOpenedHigh or c_ptMusicDoorOpenedLow, false)

    -- [BRS] - Timer decreasing
    if g_playHighAccessChime then
        g_openedAccessHighTimer = g_openedAccessHighTimer - 1
    end

    if g_playLowAccessChime then
        g_openedAccessLowTimer = g_openedAccessLowTimer - 1
    end
end