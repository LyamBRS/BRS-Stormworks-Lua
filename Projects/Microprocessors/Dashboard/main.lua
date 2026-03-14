-- [BRS] - [[ Information ]] --
-- `26/03/07`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `1`
-- ## What does this do?
-- Handles the entire dashboard, from ticks to drawing.
-- ## Where is this used?
-- Any BRS vehicles that need a simple dashboard.

-- [BRS] - [[ Imports ]] --
require("Functions.Monitor.Utils.liveColorCorrection")
require("Functions.Drawing.Gradiants.horizontalGradiant")
require("Functions.Drawing.Circles.fullControlCircleOutline")
require("Functions.Base64.Images.drawAnimatedUnicoloredImage")
require("Functions.Monitor.Utils.animateElement")
require("Variables.Monitor.Elements.function")

-- [BRS] - [[ Constants ]] --
require("Projects.Microprocessors.Dashboard.constants.speedDial")
g_base64 = property.getText("base64")

-- [BRS] - [[ Functions ]] --
-- require("Functions.Drawing.Debug.grid_position")

-- [BRS] - [[ OnTick ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    require("Projects.Microprocessors.Dashboard.onTick.getInputs")

    -- [BRS] - [[ States ]] --
    g_state()

    require("Projects.Microprocessors.Dashboard.onTick.animateUI")

    -- [BRS] - [[ Outputs ]] --
    radius = input.getNumber(3)
end

-- [BRS] - [[ OnDraw ]] --
function onDraw()
    -- require("Projects.Microprocessors.Dashboard.onDraw.background")
    require("Projects.Microprocessors.Dashboard.onDraw.speedUnit")

    screen.setColor(55,54,51, g_circleOpacity[c_animationCurrent])
    complexCircleOutline(47, 19, 11.25, g_circleStartAnimation[c_animationCurrent], g_circleEndAnimation[c_animationCurrent])

    screen.setColor(68,66,62, g_circleOpacity[c_animationCurrent])
    complexCircleOutline(47, 18, 11.25, g_circleStartAnimation[c_animationCurrent], g_circleEndAnimation[c_animationCurrent])

    screen.setColor(150,150,150, g_circleOpacity[c_animationCurrent])
    screen.drawText(41,15, "888")
    -- DEBUG_GridPosition(8, 8, 0,255,0, 255,0,255)
end

-- [BRS] - [[   Before script   ]] --
require("Projects.Microprocessors.Dashboard.beforeScript.elements")
require("Projects.Microprocessors.Dashboard.beforeScript.initialState")