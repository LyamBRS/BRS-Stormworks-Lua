-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `2`
-- ## What does this do?
-- Manages a 2x3 monitor that handles a basic addon electric charger.
-- Allows you to charge, discharge and see information about the charger.
-- Background handled seperately, in `background.lua`
-- ## Where is this used?
-- On Roadworks' server, as an EV charging station.

-- [BRS] - [[ Imports ]] --
require("Variables.Monitor.Elements.function")
require("Functions.Maths.mediumSignalStrengthToElectricStore")
require("Functions.Animations.Framework.animate")
require("Functions.Monitor.Utils.animateElement")

-- [BRS] - [[ Constants ]] --
require("Projects.Roadworks.ElectricCharger.constants.genericElements")
require("Projects.Roadworks.ElectricCharger.constants.mainMenuElements")
require("Projects.Roadworks.ElectricCharger.constants.uiConfiguration")

-- [BRS] - [[ Functions ]] --
-- [BRS] ---- Elements
require("Projects.Roadworks.ElectricCharger.functions.elements.drawTextOnSurface")
require("Projects.Roadworks.ElectricCharger.functions.elements.handleAnimatedButtons")
-- [BRS] ---- States
require("Projects.Roadworks.ElectricCharger.functions.states.stateOff")
require("Projects.Roadworks.ElectricCharger.functions.states.stateBootingUp")
require("Projects.Roadworks.ElectricCharger.functions.states.stateBootingDown")
require("Projects.Roadworks.ElectricCharger.functions.states.stateCharger")
require("Projects.Roadworks.ElectricCharger.functions.states.stateAwaitVehicleConnection")
require("Projects.Roadworks.ElectricCharger.functions.states.stateMainMenu")
-- [BRS] ---- Utilities
require("Projects.Roadworks.ElectricCharger.functions.states.bootingStateLogic")
require("Projects.Roadworks.ElectricCharger.functions.stationLight.stationLightWhenInnactive")

-- [BRS] - [[ OnTick ]] --
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

-- [BRS] - [[ OnDraw ]] --
function onDraw()
    require("Projects.Roadworks.ElectricCharger.onDraw.drawMainMenu")
    require("Projects.Roadworks.ElectricCharger.onDraw.drawAwaitVehicleConnection")
    require("Projects.Roadworks.ElectricCharger.onDraw.drawChargingVehicle")

    require("Projects.Roadworks.ElectricCharger.onDraw.drawElementTexts")

    require("Projects.Roadworks.ElectricCharger.onDraw.drawBootingFade")
    require("Projects.Roadworks.ElectricCharger.onDraw.drawingLogo")
end

-- [BRS] - [[   before script   ]] --
require("Projects.Roadworks.ElectricCharger.beforeScript.mainMenuElements")
require("Projects.Roadworks.ElectricCharger.beforeScript.awaitVehicleConnectionElements")
require("Projects.Roadworks.ElectricCharger.beforeScript.chargerElements")

require("Projects.Roadworks.ElectricCharger.beforeScript.initialState")
require("Projects.Roadworks.ElectricCharger.beforeScript.initialOutputs")
require("Projects.Roadworks.ElectricCharger.beforeScript.logoAnimations")

require("Projects.Roadworks.ElectricCharger.beforeScript.elementTexts")