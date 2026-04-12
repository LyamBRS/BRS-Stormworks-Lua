-- [BRS] - [[ INFORMATIONS ]] -
-- Manages the shifting chimes, for when you shift to different gears

if g_previousGears ~= g_gear then
    
    -- [BRS] - Shifting into drive
    if g_gear == c_gearDrive then
        setNewMusic(c_ptMusicShiftToDrive, true)
    elseif g_gear == c_gearPark and g_previousGears == c_gearNeutral then
        setNewMusic(c_ptMusicDriveToParked, true)
    elseif g_gear == c_gearPark and g_previousGears == c_gearReverse then
        setNewMusic(c_ptMusicReverseToParked, true)
    elseif g_gear == c_gearReverse then
        setNewMusic(c_ptMusicShiftToReverse, true)
    end
    g_previousGears = g_gear
    return
end