-- [BRS] - [[ Information ]] --
-- `26/03/15`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `1`
-- ## What does this do?
-- This is the manager lua script. It controls the UI of all the other lua scripts and executes a state machine accordingly.
-- ## Where is this used?
-- In the dashboard microcontroller, to offload logic from the other scripts.

-- [BRS] - [[ Imports ]] --

-- [BRS] - [[ Constants ]] --
require("Projects.Microprocessors.Dashboard.manager.constants.inputsChannels")
require("Projects.Microprocessors.Dashboard.manager.constants.outputChannels")
require("Projects.Microprocessors.Dashboard.global.constants.managerStates")

-- [BRS] - [[ Functions ]] --

-- [BRS] - [[ OnTick ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    require("Microprocessors.Dashboard.manager.onTick.getInputs")

    -- [BRS] - [[ Logic ]] --
    require("Projects.Microprocessors.Dashboard.manager.onTick.manage")

    -- [BRS] - [[ Outputs ]] --
    require("Projects.Microprocessors.Dashboard.manager.onTick.setOutputs")
end

-- [BRS] - [[   Before script   ]] --
require("Projects.Microprocessors.Dashboard.manager.beforeScript.globalVariables")