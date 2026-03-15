-- [BRS] - [[ Information ]] --
-- `26/03/15`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `2`
-- ## What does this do?
-- The sole purpose of this script is to manage the background of the dashboard
-- Moving it around as things happen, like reversing, charging, preboots or anything else
-- ## Where is this used?
-- In the dashboard microcontroller, so that scripts dont require the functions needed to show the background around.

-- [BRS] - [[ Imports ]] --
require("Functions.Drawing.Gradiants.horizontalGradiant")
require("Functions.Animations.Framework.createQuadAnimationTable")
require("Functions.Animations.Framework.setNewQuadAnimationTarget")
require("Functions.Animations.Framework.animate")
require("Functions.Animations.Functions.quadInOut")
require("Variables.Animations.current")

-- [BRS] - [[ Constants ]] --
require("Projects.Microprocessors.Dashboard.background.constants.inputsChannels")
require("Projects.Microprocessors.Dashboard.background.constants.animationDurations")
require("Projects.Microprocessors.Dashboard.global.constants.colors.background")
require("Projects.Microprocessors.Dashboard.global.constants.managerStates")

-- [BRS] - [[ Functions ]] --

-- [BRS] - [[ OnTick ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    require("Projects.Microprocessors.Dashboard.background.onTick.getInputs")

    -- [BRS] - [[ Logic ]] --
    ------------------------- Nothing executes if the manager doesn't tell you so.
    if not g_scriptsOn then
        return
    end
    require("Projects.Microprocessors.Dashboard.background.onTick.manage")
    require("Projects.Microprocessors.Dashboard.background.onTick.animate")
end

-- [BRS] - [[ OnDraw ]] --
function onDraw()
    ------------------------- Nothing executes if the manager doesn't tell you so.
    if not g_scriptsOn then
        return
    end

    require("Projects.Microprocessors.Dashboard.background.onDraw.drawBackground")
end


-- [BRS] - [[   Before script   ]] --
require("Projects.Microprocessors.Dashboard.background.beforeScript.globalVariables")
require("Projects.Microprocessors.Dashboard.background.beforeScript.animations")