require("Functions.Monitor.Buttons.Animated.newAnimatedRectangleGradiantButton")
require("Functions.Animations.Functions.elasticOut")
require("Projects.Roadworks.ElectricCharger.constants.mainMenuElements")
require("Variables.Monitor.Elements.surface")

g_chargeButton = newAnimatedRectangleGradiantButton(
    c_chargeButtonXHidden,41,
    64,9,
    0,255,0,  150,
    0,64,64,128,
    elasticOutAnimation
)
g_dischargeButton = newAnimatedRectangleGradiantButton(
    c_dischargeButtonXHidden,52,
    64,9,
    255,0,  128,128,
    255,128,0,  128,
    elasticOutAnimation
)
-- g_infoButton = newAnimatedRectangleGradiantButton(
--     c_infoButtonXHidden,52,
--     64,9,
--     0,  255,128,128,
--     128,0,  255,128,
--     elasticOutAnimation
-- )

g_mainMenuText = newAnimatedRectangleGradiantButton(
    2, c_mainMenuTextYHidden,       -- x, y
    92, 26,                         -- width, height
    0,0,0,80,                       -- r, g, b, a
    255,255,255,64,                       -- r, g, b, a
    elasticOutAnimation             -- animation function
)

-- [BRS] - [[ Minifications ]]
g_chargeButtonSurfaceX = g_chargeButton[c_elementSurface][c_elementSurfaceX]
g_dischargeButtonSurfaceX = g_dischargeButton[c_elementSurface][c_elementSurfaceX]
-- g_infoButtonSurfaceX = g_infoButton[c_elementSurface][c_elementSurfaceX]
g_mainMenuTextSurfaceX = g_mainMenuText[c_elementSurface][c_elementSurfaceX]