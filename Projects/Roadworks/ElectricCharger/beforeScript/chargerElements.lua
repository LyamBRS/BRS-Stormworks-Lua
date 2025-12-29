require("Functions.Monitor.Buttons.Animated.newAnimatedRectangleGradiantButton")
require("Functions.Animations.Framework.quintInOutAnimation")
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

-- [BRS] - [[ Minifications ]]
g_cancelChargingButtonSurface = g_cancelChargingButton[c_elementSurface]
g_chargingVehicleTextSurface = g_chargingVehicleText[c_elementSurface]