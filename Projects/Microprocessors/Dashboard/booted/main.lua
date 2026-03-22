-- [BRS] - [[ Information ]] --
-- `26/03/15`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `1`
-- ## What does this do?
-- Shows the main screen of the dashboard, with the dials and stuff.
-- ## Where is this used?
-- In BRS Dashboard v2

-- [BRS] - [[ Imports ]] --
require("Functions.Monitor.Utils.liveColorCorrection")
require("Functions.Animations.Framework.animate")
require("Functions.Drawing.Circles.fullControlCircleOutline")
require("Functions.Animations.Framework.setNewQuadAnimationTarget")
require("Variables.Monitor.Elements.surface")
require("Variables.Monitor.Elements.colors")
require("Variables.Monitor.Elements.function")
require("Variables.Physic_sensor.velocities.absolutes")

-- [BRS] - [[ Constants ]] --
require("Projects.Microprocessors.Dashboard.global.variables.base64")
require("Projects.Microprocessors.Dashboard.global.constants.controls.gears")
require("Projects.Microprocessors.Dashboard.global.constants.controls.lightSettings")
require("Projects.Microprocessors.Dashboard.booted.constants.animationPositions")
require("Projects.Microprocessors.Dashboard.booted.constants.animationDurations")
require("Projects.Microprocessors.Dashboard.booted.constants.inputChannels")
require("Projects.Microprocessors.Dashboard.booted.constants.outputChannels")
require("Projects.Microprocessors.Dashboard.global.constants.colors.speedDial")
require("Projects.Microprocessors.Dashboard.global.constants.colors.generic")
require("Projects.Microprocessors.Dashboard.global.constants.colors.speed")
require("Projects.Microprocessors.Dashboard.global.constants.controls.speed")

-- [BRS] - [[ Functions ]] --

-- [BRS] - [[ OnTick ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    require("Projects.Microprocessors.Dashboard.booted.onTick.getInputs")
    if not g_scriptsOn then
        return
    end
    require("Projects.Microprocessors.Dashboard.booted.onTick.animate")
    require("Projects.Microprocessors.Dashboard.booted.onTick.bootAnimations")
    require("Projects.Microprocessors.Dashboard.booted.onTick.showingManager")

    require("Projects.Microprocessors.Dashboard.booted.onTick.speed")
    require("Projects.Microprocessors.Dashboard.booted.onTick.blinkers")

    -- [BRS] - [[ Outputs ]] --
    require("Projects.Microprocessors.Dashboard.booted.onTick.setOutputs")
end

-- [BRS] - [[ OnDraw ]] --
function onDraw()
    if not g_scriptsOn then
        return
    end
    require("Projects.Microprocessors.Dashboard.booted.onDraw.speedDial")
    require("Projects.Microprocessors.Dashboard.booted.onDraw.speedUnit")
    require("Projects.Microprocessors.Dashboard.booted.onDraw.blinkers")
end

-- [BRS] - [[   Before script   ]] --
require("Projects.Microprocessors.Dashboard.booted.beforeScript.globalVariables")
require("Projects.Microprocessors.Dashboard.booted.beforeScript.elements")