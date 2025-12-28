require("Functions.Monitor.Buttons.Animated.newAnimatedRectangleGradiantButton")
require("Functions.Animations.Framework.elasticOut")
require("Projects.Roadworks.ElectricCharger.constants.mainMenuElements")
require("Variables.Monitor.Elements.surface")

g_chargeButton = newAnimatedRectangleGradiantButton(
    c_chargeButtonXHidden,30,
    64,9,
    128,255,0,  128,
    0,  255,128,128,
    elasticOutAnimation
)
g_dischargeButton = newAnimatedRectangleGradiantButton(
    c_dischargeButtonXHidden,41,
    64,9,
    255,0,  128,128,
    255,128,0,  128,
    elasticOutAnimation
)
g_infoButton = newAnimatedRectangleGradiantButton(
    c_infoButtonXHidden,52,
    64,9,
    0,  255,128,128,
    128,0,  255,128,
    elasticOutAnimation
)

-- [BRS] - [[ Minifications ]]
g_chargeButtonSurface = g_chargeButton[c_elementSurface]
g_dischargeButtonSurface = g_dischargeButton[c_elementSurface]
g_infoButtonSurface = g_infoButton[c_elementSurface]