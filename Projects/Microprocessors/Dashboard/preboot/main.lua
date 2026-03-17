-- [BRS] - [[ Information ]] --
-- `26/03/16`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `3`
-- ## What does this do?
-- Shows the preboot screen up, when the car is off but a player is nearby.
-- ## Where is this used?
-- In BRS Lua dashboard v2

-- [BRS] - [[ Imports ]] --
require("Functions.Monitor.Utils.liveColorCorrection")
require("Functions.Monitor.Utils.animateElement")
require("Functions.Animations.Framework.setNewQuadAnimationTarget")
require("Variables.Monitor.Elements.function")
require("Variables.Monitor.Elements.surface")
require("Variables.Monitor.Elements.colors")

-- [BRS] - [[ Constants ]] --
require("Projects.Microprocessors.Dashboard.preboot.constants.animationPositions")
require("Projects.Microprocessors.Dashboard.preboot.constants.colors")
require("Projects.Microprocessors.Dashboard.preboot.constants.inputChannels")
require("Projects.Microprocessors.Dashboard.preboot.constants.outputChannels")
require("Projects.Microprocessors.Dashboard.preboot.constants.animationDurations")
require("Projects.Microprocessors.Dashboard.global.constants.managerStates")
require("Projects.Microprocessors.Dashboard.global.constants.positions.brsFont")
require("Projects.Microprocessors.Dashboard.global.constants.positions.monitor")

-- [BRS] - [[ Functions ]] --

-- [BRS] - [[ OnTick ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    require("Projects.Microprocessors.Dashboard.preboot.onTick.getInputs")
    output.setNumber(1, g_uiShownAnimation[c_animationCurrent])

    if not g_scriptsOn or g_managerState == c_stateBooted then
        return
    end
    require("Projects.Microprocessors.Dashboard.preboot.onTick.animateUI")
    require("Projects.Microprocessors.Dashboard.preboot.onTick.manage")
    require("Projects.Microprocessors.Dashboard.preboot.onTick.showingManager")
    -- [BRS] - [[ Outputs ]] --
    require("Projects.Microprocessors.Dashboard.preboot.onTick.setOutputs")
end

-- [BRS] - [[ OnDraw ]] --
function onDraw()
    if not g_scriptsOn or g_managerState == c_stateBooted then
        return
    end
    require("Projects.Microprocessors.Dashboard.preboot.onDraw.vehicleName")
end

-- [BRS] - [[   Before script   ]] --
require("Projects.Microprocessors.Dashboard.global.variables.base64")
require("Projects.Microprocessors.Dashboard.preboot.beforeScript.globalVariables")
require("Projects.Microprocessors.Dashboard.preboot.beforeScript.elements")