-- [BRS] - [[ Information ]] --
-- `26/03/29`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles the fast spinning radar target detection
-- Outputs data required for the vehicle to perform actions
-- ## Where is this used?
-- Vehicles and prosty in general

-- [BRS] - [[ Imports ]] --
require("Functions.Physic_sensor.Euler.toForwardVector")
require("Functions.Radar.vector.anglesToVector")
require("Functions.Vectors.angleDifference")

-- [BRS] - [[ Constants ]] --
require("Projects.Prosty.global.constants.controls.lights")
require("Projects.Prosty.global.constants.settings.lights")
require("Projects.Prosty.FrontRadarManager.constants.inputChannels")
require("Projects.Prosty.FrontRadarManager.constants.outputChannels")
require("Projects.Prosty.FrontRadarManager.constants.radar")
require("Projects.Prosty.FrontRadarManager.constants.targets")

-- [BRS] - [[ Functions ]] --

-- [BRS] - [[ OnTick ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    require("Projects.Prosty.FrontRadarManager.onTick.inputs")
    require("Projects.Prosty.FrontRadarManager.onTick.getCarData")
    require("Projects.Prosty.FrontRadarManager.onTick.updateTargets")
    require("Projects.Prosty.FrontRadarManager.onTick.getRadarData")

    require("Projects.Prosty.FrontRadarManager.onTick.frontOfCarDetection")
    -- [BRS] - [[ Outputs ]] --
    require("Projects.Prosty.FrontRadarManager.onTick.outputs")

    output.setNumber(1, g_vehicleVector[1])
    output.setNumber(2, g_vehicleVector[2])
    output.setNumber(3, g_vehicleVector[3])

    fuck = false
    for i=1, #g_targets do
        target = g_targets[i]
        if target[c_targetElevation] == 0 and target[c_targetAzimuth] == 0 and target[c_targetDistance] == 0 then
            fuck = true
        end
    end
    output.setBool(2, fuck)
end

-- [BRS] - [[   Before script   ]] --
require("Projects.Prosty.FrontRadarManager.beforeScript.targets")
require("Projects.Prosty.FrontRadarManager.beforeScript.globals")