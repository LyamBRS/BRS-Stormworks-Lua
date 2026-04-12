-- [BRS] - [[ INFORMATIONS ]] -
-- Manages the access opened chimes. 
-- This has a lesser priority than the seatbelt alarm
--
-- Active if the ignition is on, not in park and you're moving.

if g_vehicleOn and g_gear ~= c_gearPark and g_velocity > .1 and not g_playingMusic then
    setNewMusic(c_ptMusicDoorOpened, false)
end