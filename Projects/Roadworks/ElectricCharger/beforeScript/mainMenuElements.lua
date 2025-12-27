require("Functions.Monitor.Buttons.Animated.newAnimatedRectangleGradiantButton")
require("Projects.Roadworks.ElectricCharger.constants.mainMenuElements")

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