screen.setColor(
    g_leftBlinkerAnimation[1][c_animationCurrent],
    g_leftBlinkerAnimation[2][c_animationCurrent],
    g_leftBlinkerAnimation[3][c_animationCurrent],
    g_leftBlinkerAnimation[4][c_animationCurrent]
)
screen.drawRectF(36,7,4,1)

screen.setColor(
    g_rightBlinkerAnimation[1][c_animationCurrent],
    g_rightBlinkerAnimation[2][c_animationCurrent],
    g_rightBlinkerAnimation[3][c_animationCurrent],
    g_rightBlinkerAnimation[4][c_animationCurrent]
)
screen.drawRectF(56,7,4,1)