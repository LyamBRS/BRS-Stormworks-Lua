require("Projects.Prosty.MainController.variables")

function onTick()
	-- [BRS] - All the inputs of the Lua script are there.
	require("Projects.Prosty.MainController.inputs")
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

	-- [BRS] - All the outputs of this Lua script are there.
	require("Projects.Prosty.MainController.outputs")
end