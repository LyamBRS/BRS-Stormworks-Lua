-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `1`
-- ## What does this do?
-- Manages a 2x3 monitor that handles a basic addon electric charger.
-- Allows you to charge, discharge and see information about the charger.
-- Has crazy background animations and button gradiants.
-- ## Where is this used?
-- On Roadworks' server, as an EV charging station.

-- [BRS] - [[  imports  ]] --
require("Projects.Roadworks.ElectricCharger.constants.constants")
require("Projects.Roadworks.ElectricCharger.functions.functions")

function onTick()
    -- [BRS] - [[ Inputs ]] --
    require("Functions.Monitor.onTickVariableGetting")
    require("Projects.Roadworks.ElectricCharger.onTick.getInputs")

    -- [BRS] - [[ State machine ]] --
    g_state()

    -- [BRS] - [[ Outputs ]] --
    require("Projects.Roadworks.ElectricCharger.onTick.setOutputs")

    -- Calculating electric store from inputs
    g_electricStore = mediumSignalStrengthToElectricStore(g_antennaSignalStrength)

    -- [BRS] - [[ Synchronized UI ]] --
    require("Projects.Roadworks.ElectricCharger.onTick.animateUI")
    require("Projects.Roadworks.ElectricCharger.onTick.handleButtons")
end

function onDraw()
    require("Projects.Roadworks.ElectricCharger.onDraw.drawBackground")
    require("Projects.Roadworks.ElectricCharger.onDraw.drawMainMenu")
    require("Projects.Roadworks.ElectricCharger.onDraw.drawAwaitVehicleConnection")
    require("Projects.Roadworks.ElectricCharger.onDraw.drawChargingVehicle")
    require("Projects.Roadworks.ElectricCharger.onDraw.drawBootingFade")
    require("Projects.Roadworks.ElectricCharger.onDraw.drawingLogo")

    screen.setColor(255,255,255)
    screen.drawText(0,0,g_electricStore)
end

require("Projects.Roadworks.ElectricCharger.beforeScript.beforeScript")