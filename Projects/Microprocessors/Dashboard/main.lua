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

-- [BRS] - [[ Constants ]] --

-- [BRS] - [[ Functions ]] --
require("Functions.Drawing.Debug.grid_position")

-- [BRS] - [[ OnTick ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    require("Projects.Microprocessors.Dashboard.onTick.getInputs")

    -- [BRS] - [[ Outputs ]] --
    circleX = input.getNumber(1)
    circleY = input.getNumber(2)
    circleR = input.getNumber(3)
    endCircle = input.getNumber(4)
    startCircle = input.getNumber(5)
end

-- [BRS] - [[ OnDraw ]] --
function onDraw()
    require("Projects.Microprocessors.Dashboard.onDraw.background")
    require("Projects.Microprocessors.Dashboard.onDraw.speedUnit")

    screen.setColor(55,54,51)
    complexCircleOutline(47, 19, 10.3, -.82, 3.96)

    screen.setColor(68,66,62)
    complexCircleOutline(47, 19, 11.25, -.82, 3.96)

    screen.setColor(150,150,150)
    screen.drawText(41,16, "888")
    -- DEBUG_GridPosition(8, 8, 0,255,0, 255,0,255)
end

-- [BRS] - [[   Before script   ]] --
-- Execution outside of onFunctions.