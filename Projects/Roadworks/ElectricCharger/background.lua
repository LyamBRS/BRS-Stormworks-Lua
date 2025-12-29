-- [BRS] - [[ Information ]] --
-- `2025/12/29`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `1`
-- ## What does this do?
-- Handles the bezier curve background of the 3x2 monitor.
-- It was originally in the same Lua script as `main.lua` but had to
-- be moved away due to character constraint (even when minified).
-- The whole thing could've fit together if I spent more time on character
-- optimizations.
-- ## Where is this used?
-- used in BRS' Roadworks' EV charger.

-- [BRS] - [[ Imports ]] --

-- [BRS] - [[ Constants ]] --
-- [BRS] ---- Configurations
require("Projects.Roadworks.ElectricCharger.constants.backgroundConfiguration")
-- [BRS] ---- Object indexes
require("Projects.Roadworks.ElectricCharger.constants.coordinateObject")
require("Projects.Roadworks.ElectricCharger.constants.curveObject")
require("Projects.Roadworks.ElectricCharger.constants.segmentObject")

-- [BRS] - [[ Functions ]] --
-- [BRS] ---- Bezier handling
require("Projects.Roadworks.ElectricCharger.functions.background.bezierPoints")
require("Projects.Roadworks.ElectricCharger.functions.background.drawBezier")
-- [BRS] ---- Drawing management
require("Projects.Roadworks.ElectricCharger.functions.background.circleFade")
-- [BRS] ---- Animation management
require("Projects.Roadworks.ElectricCharger.functions.background.createBackgroundAnimation")
require("Projects.Roadworks.ElectricCharger.functions.background.handleAnimationEnd")
require("Projects.Roadworks.ElectricCharger.functions.background.handleColorAnimations")

-- [BRS] - [[ OnDraw ]] --
function onDraw()
    require("Projects.Roadworks.ElectricCharger.onDraw.drawBackground")
end

-- [BRS] - [[   before script   ]] --
require("Projects.Roadworks.ElectricCharger.beforeScript.createBezierCurves")