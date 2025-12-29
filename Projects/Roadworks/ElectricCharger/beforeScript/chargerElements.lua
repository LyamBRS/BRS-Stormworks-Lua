require("Functions.Monitor.Buttons.Animated.newAnimatedRectangleGradiantButton")
require("Functions.Animations.Functions.quintInOutAnimation")
require("Projects.Roadworks.ElectricCharger.constants.mainMenuElements")
require("Variables.Monitor.Elements.surface")

g_cancelChargingButton = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX,52,
    64,9,
    128,32,32,  128,
    64,64,64,128,
    quintInOutAnimation
)

g_chargingVehicleText = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX, c_textAreaYShown,       -- x, y
    92, 26,                         -- width, height
    255,255,0,64,                   -- r, g, b, a
    255,0,255,64,                   -- r, g, b, a
    quintInOutAnimation             -- animation function
)

g_batteryChargeBar = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX,41,
    64,9,
    128,32,32,  128,
    64,64,64,128,
    quintInOutAnimation
)

-- Adding 2 more colors to the charging bar
-- g_batteryChargeBar[c_elementColors][3] = {
--     create
-- }

-- [BRS] - [[ Minifications ]]
g_cancelChargingButtonSurfaceX = g_cancelChargingButton[c_elementSurface][c_elementSurfaceX]
g_chargingVehicleTextSurfaceX = g_chargingVehicleText[c_elementSurface][c_elementSurfaceX]