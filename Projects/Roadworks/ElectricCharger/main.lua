require("Projects.Roadworks.ElectricCharger.constants.constants")
require("Projects.Roadworks.ElectricCharger.functions.functions")
require("Functions.Drawing.Logo.brs_b")
require("Functions.Drawing.Logo.brs_r")
require("Functions.Drawing.Logo.brs_s")

function onTick()
    -- [BRS] - Empty for now.
end

function onDraw()
    require("Projects.Roadworks.ElectricCharger.onDraw.drawBackground")

    screen.setColor(255,255,255)
    logoB(0, 0, 1)
    logoR(6, 0, 1)
    logoS(12, 0, 1)
end

require("Projects.Roadworks.ElectricCharger.beforeScript.beforeScript")