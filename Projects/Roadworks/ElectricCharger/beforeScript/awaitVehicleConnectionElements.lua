require("Functions.Monitor.Buttons.Animated.newAnimatedRectangleGradiantButton")
require("Functions.Animations.Functions.quintInOutAnimation")
require("Projects.Roadworks.ElectricCharger.constants.mainMenuElements")
require("Variables.Monitor.Elements.surface")

g_yesButton = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX,41,
    64,9,
    0,128,0,  128,
    0,64,64,128,
    quintInOutAnimation
)

g_noButton = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX,52,
    64,9,
    200,0,16,128,
    100,0,100,128,
    quintInOutAnimation
)

g_awaitVehicleConnectionText = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX, c_textAreaYShown,       -- x, y
    92, 26,                         -- width, height
    255,100,0,90,                   -- r, g, b, a
    128,0,255,80,                   -- r, g, b, a
    quintInOutAnimation             -- animation function
)