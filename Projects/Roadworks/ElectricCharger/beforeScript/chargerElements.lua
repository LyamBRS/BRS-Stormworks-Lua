require("Functions.Monitor.Buttons.Animated.newAnimatedRectangleGradiantButton")
require("Functions.Animations.Functions.quintInOutAnimation")
require("Projects.Roadworks.ElectricCharger.constants.mainMenuElements")
require("Variables.Monitor.Elements.surface")

g_cancelChargingButton = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX,52,
    64,9,
    128,8,16,128,
    64,64,8,128,
    quintInOutAnimation
)

g_chargingVehicleText = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX, c_textAreaYShown,       -- x, y
    92, 26,                         -- width, height
    0,0,0,0,                   -- r, g, b, a
    0,0,0,0,                   -- r, g, b, a
    quintInOutAnimation             -- animation function
)

g_batteryChargeBarBot = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX,41,
    64,9,
    32,32,32,32,
    32,32,32,32,
    quintInOutAnimation
)

g_batteryChargeBarTop = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX+1,42,
    62,7,
    32,32,32,255,
    32,32,32,255,
    quintInOutAnimation
)

-- [BRS] - Used to identify if a battery charges or not.
g_previousElectricStore = 0
-- [BRS] - Counts how long the electric store stayed the same
g_electricCounter = 0
-- [BRS] - Counts how long the charging session lasted for.
g_currentSessionTimer = 0