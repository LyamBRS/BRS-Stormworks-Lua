require("Projects.Prosty.MainController.variables")

-- [BRS] - [[ Imports ]] --

-- [BRS] - [[ Constants ]] --
require("Projects.Prosty.MainController.constants.inputsChannels")
require("Projects.Prosty.MainController.constants.outputChannels")
require("Projects.Prosty.MainController.constants.seatbelt")
require("Projects.Prosty.MainController.constants.doors")

-- [BRS] - [[ Functions ]] --

-- [BRS] - [[ OnTick ]] --
function onTick()
	-- [BRS] - All the inputs of the Lua script are there.
	require("Projects.Prosty.MainController.onTick.inputs")
	require("Projects.Prosty.MainController.gearManagement")
	require("Projects.Prosty.MainController.brakeManagement")
	require("Projects.Prosty.MainController.throttleManagement")
	require("Projects.Prosty.MainController.steeringManagement")
	require("Projects.Prosty.MainController.beamManagement")
	require("Projects.Prosty.MainController.brakelights")
	require("Projects.Prosty.MainController.reverseLight")
	require("Projects.Prosty.MainController.tailight")
	require("Projects.Prosty.MainController.blinkers")
	require("Projects.Prosty.MainController.spotlight")
	require("Projects.Prosty.MainController.doors")

	require("Projects.Prosty.MainController.onTick.seatBeltAlarm")

	-- [BRS] - All the outputs of this Lua script are there.
	require("Projects.Prosty.MainController.onTick.outputs")
end

require("Functions.Vehicles.Cars.Steering.ackerman")
require("Functions.Vehicles.Cars.Steering.angularStabilization")
require("Projects.Prosty.MainController.beforeScript.globals")