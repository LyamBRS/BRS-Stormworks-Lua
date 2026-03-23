g_speedUnitLetter1[c_elementFunction](g_speedUnitLetter1)
g_speedUnitLetter2[c_elementFunction](g_speedUnitLetter2)
g_speedUnitLetter3[c_elementFunction](g_speedUnitLetter3)

-- [BRS] - Speed text
screen.setColor(
    g_speedTextColor[1][c_animationCurrent],
    g_speedTextColor[2][c_animationCurrent],
    g_speedTextColor[3][c_animationCurrent],
    g_speedTextColor[4][c_animationCurrent]
)

screen.drawTextBox(
    g_speedTextPosition[1][c_animationCurrent],
    g_speedTextPosition[2][c_animationCurrent],
    15,
    5,
    g_speed,
    0,
    0
)