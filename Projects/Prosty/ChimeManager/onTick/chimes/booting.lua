-- [BRS] - [[ INFORMATIONS ]] -
-- Manages the boot chimes. These are the sounds with the up most priorities.
-- Called by a previous checker in main.lua

if g_previousVehicleOn ~= g_vehicleOn then
    g_previousVehicleOn = g_vehicleOn
    
    if g_vehicleOn then
        -- [BRS] - Start up chime must be played this instant.
        setNewMusic(c_ptMusicStartChime, true)
    else
        -- [BRS] - Bootoff chime must be played this instant.
        setNewMusic(c_ptMusicOffChime, true)
    end
    return
end