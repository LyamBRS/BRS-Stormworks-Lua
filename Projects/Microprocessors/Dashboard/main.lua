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

-- [BRS] - [[ Constants ]] --

-- [BRS] - [[ Functions ]] --

-- [BRS] - [[ OnTick ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    require("Projects.Microprocessors.Dashboard.onTick.getInputs")

    -- [BRS] - [[ Outputs ]] --
end

-- [BRS] - [[ OnDraw ]] --
function onDraw()
    require("Projects.Microprocessors.Dashboard.onDraw.background")
end

-- [BRS] - [[   Before script   ]] --
-- Execution outside of onFunctions.