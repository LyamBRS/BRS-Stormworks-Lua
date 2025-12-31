require("Functions.Monitor.Buttons.Animated.newAnimatedRectangleGradiantButton")
require("Functions.Animations.Functions.quintInOutAnimation")
require("Projects.Roadworks.ElectricCharger.constants.mainMenuElements")
require("Variables.Monitor.Elements.surface")

g_okFinishedSessionButton = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX,52,
    64,9,
    0,128,0,128,
    0,64,64,128,
    quintInOutAnimation
)

g_finishedSessionText = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX, c_textAreaYShown,   -- x, y
    92, 26,                                     -- width, height
    0,0,255,80,                                    -- r, g, b, a
    255,0,0,80,                                    -- r, g, b, a
    quintInOutAnimation                         -- animation function
)

g_finishedSessionTime = newAnimatedRectangleGradiantButton(
    c_mainMenuToDischargeX,41,
    64,9,
    0,0,0,0,
    0,0,0,0,
    quintInOutAnimation
)

-- [BRS] - Used to boot off the monitor if the player is away for long enough
g_timeBeforeBootOff = 0