-- [BRS] - [[ INFORMATIONS ]] -
-- Draws the main battery level, shown under the speed dial usually.

screen.setColor(255,255,255)
screen.drawRectF(
    g_batteryPosition[c_elementSurfaceX][c_animationCurrent],
    g_batteryPosition[c_elementSurfaceY][c_animationCurrent],
    g_batteryPosition[c_elementSurfaceW][c_animationCurrent],
    g_batteryPosition[c_elementSurfaceH][c_animationCurrent]
)