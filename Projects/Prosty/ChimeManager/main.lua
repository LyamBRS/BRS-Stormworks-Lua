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
require("Projects.Prosty.ChimeManager.constants.seatBeltAlarmLevels")
require("Projects.Prosty.global.constants.controls.gears")
require("Projects.Prosty.global.constants.settings.doors")

-- [BRS] - [[ Functions ]] --
require("Projects.Prosty.ChimeManager.functions.setNewMusic")

-- [BRS] - [[ OnTick ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    require("Projects.Prosty.ChimeManager.onTick.getInputs")

    -- [BRS] - [[ MUSIC ]] -- 
    require("Projects.Prosty.ChimeManager.onTick.playMusic")

    require("Projects.Prosty.ChimeManager.onTick.doorManager")

    -- [BRS] - [[ MANAGEMENT ]] --
    if not g_awaitedMusic then
        -- These must be ordered in their priority.
        -- Each has a return statement at the end of their ifs checkers
        -- Meaning if they get to execute, nobody below them should be able to.
        require("Projects.Prosty.ChimeManager.onTick.chimes.booting")
        require("Projects.Prosty.ChimeManager.onTick.chimes.shifting")
        require("Projects.Prosty.ChimeManager.onTick.chimes.seatbelt")
        require("Projects.Prosty.ChimeManager.onTick.chimes.openedAccess")
    end

    -- [BRS] - [[ Outputs ]] --
end

-- [BRS] - [[   Before script   ]] --
require("Projects.Prosty.ChimeManager.beforeScript.base64")
require("Projects.Prosty.ChimeManager.beforeScript.globals")