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
require("Projects.Prosty.ChimeManager.constants.seatbeltDurations")
require("Projects.Prosty.ChimeManager.constants.seatBeltAlarmLevels")

-- [BRS] - [[ Functions ]] --
require("Projects.Prosty.ChimeManager.functions.setNewMusic")

-- [BRS] - [[ OnTick ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    require("Projects.Prosty.ChimeManager.onTick.getInputs")

    -- [BRS] - [[ Logic ]] --
    require("Projects.Prosty.ChimeManager.onTick.seatBeltManager")

    -- [BRS] - [[ MUSIC ]] -- 
    require("Projects.Prosty.ChimeManager.onTick.playMusic")

    -- [BRS] - [[ MANAGEMENT ]] --
    if not g_awaitedMusic then
        if g_previousVehicleOn ~= g_vehicleOn then
            g_previousVehicleOn = g_vehicleOn
            require("Projects.Prosty.ChimeManager.onTick.bootChimes")
            return
        end

        if g_seatBeltAlarmLevel ~= c_seatBeltAlarmOff then
            require("Projects.Prosty.ChimeManager.onTick.seatbeltChimes")
        end
    end

    -- [BRS] - [[ Outputs ]] --
end

-- [BRS] - [[   Before script   ]] --
require("Projects.Prosty.ChimeManager.beforeScript.base64")
require("Projects.Prosty.ChimeManager.beforeScript.globals")