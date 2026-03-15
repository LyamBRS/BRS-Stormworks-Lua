-- [BRS] - Draws the main gradiant background of the dashboard.
screen.setColor(25,25,25)
screen.drawClear()

horizontalGradiant(
    0,0,96,32,
    g_backgroundR[c_animationCurrent],g_backgroundG[c_animationCurrent],g_backgroundB[c_animationCurrent],g_backgroundTop[c_animationCurrent],
    g_backgroundR[c_animationCurrent],g_backgroundG[c_animationCurrent],g_backgroundB[c_animationCurrent],g_backgroundBot[c_animationCurrent]
)