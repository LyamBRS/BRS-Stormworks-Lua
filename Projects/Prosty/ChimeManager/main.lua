-- [BRS] - [[ Information ]] --
-- `26/03/24`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number`
-- ## What does this do?
-- Manages the different chimes and warning messages that must be played at all times.
-- ## Where is this used?
-- In Prosty, for startup chimes and boot off chimes, seatbelt noises and other warning musics

-- [BRS] - [[ Imports ]] --
require("Functions.Base64.Music.playMusic")
require("Functions.Base64.Music.decodeMusic")

-- [BRS] - [[ Constants ]] --
require("Projects.Prosty.ChimeManager.constants.inputChannels")
require("Projects.Prosty.ChimeManager.constants.outputChannels")
require("Projects.Prosty.ChimeManager.constants.propertyNames")

-- [BRS] - [[ Functions ]] --
require("Projects.Prosty.ChimeManager.functions.setNewMusic")

-- [BRS] - [[ OnTick ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    require("Projects.Prosty.ChimeManager.onTick.getInputs")

    -- [BRS] - [[ MUSIC ]] -- 
    require("Projects.Prosty.ChimeManager.onTick.playMusic")

    -- [BRS] - [[ TESTS ]] --
    if g_previousVehicleOn ~= g_vehicleOn then
        g_previousVehicleOn = g_vehicleOn

        if g_vehicleOn then
            -- [BRS] - Start up chime must be played this instant.
            setNewMusic(c_ptMusicStartChime, true)
        else
            -- [BRS] - Bootoff chime must be played this instant.
            setNewMusic(c_ptMusicOffChime, true)
        end
    end

    -- [BRS] - [[ Outputs ]] --
end

-- [BRS] - [[   Before script   ]] --
require("Projects.Prosty.ChimeManager.beforeScript.base64")
require("Projects.Prosty.ChimeManager.beforeScript.globals")