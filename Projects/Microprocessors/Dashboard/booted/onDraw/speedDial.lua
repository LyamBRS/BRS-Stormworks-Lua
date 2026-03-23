screen.setColor(
    g_speedDialInnerColorAnimations[1][c_animationCurrent],
    g_speedDialInnerColorAnimations[2][c_animationCurrent],
    g_speedDialInnerColorAnimations[3][c_animationCurrent],
    g_speedDialInnerColorAnimations[4][c_animationCurrent]
)
complexCircleOutline(
    47, 19, 11.25,
    g_speedDialRadiansAnimations[1][c_animationCurrent],
    g_speedDialRadiansAnimations[2][c_animationCurrent]
)

screen.setColor(
    g_speedDialOuterColorAnimations[1][c_animationCurrent],
    g_speedDialOuterColorAnimations[2][c_animationCurrent],
    g_speedDialOuterColorAnimations[3][c_animationCurrent],
    g_speedDialOuterColorAnimations[4][c_animationCurrent]
)
complexCircleOutline(
    47, 18, 11.25,
    g_speedDialRadiansAnimations[1][c_animationCurrent],
    g_speedDialRadiansAnimations[2][c_animationCurrent]
)

screen.setColor(
    g_speedTextColor[1][c_animationCurrent],
    g_speedTextColor[2][c_animationCurrent],
    g_speedTextColor[3][c_animationCurrent],
    g_speedTextColor[4][c_animationCurrent]
)

-- [BRS] - BAD CODE WARNING
-- Here I take advantage of the fact that all my variables are global.
-- Since the complexCircleOutline called above still has its values saved in variables
-- and dynamically changing the radians fucks up the pixel precisions and i do not want
-- to make a less efficient circle drawing... I reuse the variables computed.
-- `step` says how much the for loop neeeded to increase by
-- `segments` says how much pixels we needed to draw
-- so i multiply the speed by that.
for i = 0, segments * (g_speed / c_maxSpeed) do
    radian =  g_speedDialRadiansAnimations[1][c_animationCurrent] + i * step
    screen.drawRectF(
        47 + 11.25 * -math.cos(radian),
        18 - 11.25 * math.sin(radian),
        1,
        1
    )
    
    screen.drawRectF(
        47 + 11.25 * -math.cos(radian),
        19 - 11.25 * math.sin(radian),
        1,
        1
    )
end