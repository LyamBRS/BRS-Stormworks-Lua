require("Projects.Roadworks.ElectricCharger.constants.constants")
require("Projects.Roadworks.ElectricCharger.functions.functions")

require("Functions.Drawing.Gradiants.rounded45DegreeGradient")

function onTick()
    -- Input reading
    require("Functions.Monitor.onTickVariableGetting")
    require("Projects.Roadworks.ElectricCharger.onTick.getInputs")

    -- State machine execution
    g_state()

    -- Output setting
    require("Projects.Roadworks.ElectricCharger.onTick.setOutputs")

    -- Animations
    require("Projects.Roadworks.ElectricCharger.onTick.animateUI")
end

function onDraw()
    require("Projects.Roadworks.ElectricCharger.onDraw.drawBackground")
    require("Projects.Roadworks.ElectricCharger.onDraw.drawMainMenu")
    require("Projects.Roadworks.ElectricCharger.onDraw.drawBootingFade")
    require("Projects.Roadworks.ElectricCharger.onDraw.drawingLogo")
end

require("Projects.Roadworks.ElectricCharger.beforeScript.beforeScript")