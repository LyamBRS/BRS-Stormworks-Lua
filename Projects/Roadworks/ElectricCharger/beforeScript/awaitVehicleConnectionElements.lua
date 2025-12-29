require("Functions.Monitor.Buttons.Animated.newAnimatedRectangleGradiantButton")
require("Functions.Animations.Functions.quintInOutAnimation")
require("Projects.Roadworks.ElectricCharger.constants.mainMenuElements")
require("Variables.Monitor.Elements.surface")

g_okButton = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX,41,
    64,9,
    0,128,0,  128,
    0,64,64,128,
    quintInOutAnimation
)

g_cancelButton = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX,52,
    64,9,
    128,32,32,  128,
    64,64,64,128,
    quintInOutAnimation
)

g_awaitVehicleConnectionText = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX, c_textAreaYShown,       -- x, y
    92, 26,                         -- width, height
    255,255,0,64,                   -- r, g, b, a
    255,0,255,64,                   -- r, g, b, a
    quintInOutAnimation             -- animation function
)

-- [BRS] - [[ Minifications ]]
g_cancelButtonSurfaceX = g_cancelButton[c_elementSurface][c_elementSurfaceX]
g_okButtonSurfaceX = g_okButton[c_elementSurface][c_elementSurfaceX]
g_awaitVehicleConnectionTextSurfaceX = g_awaitVehicleConnectionText[c_elementSurface][c_elementSurfaceX]