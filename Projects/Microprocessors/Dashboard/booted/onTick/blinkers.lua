if g_leftBlinker ~= g_previousLeftBlinker then
    g_previousLeftBlinker = g_leftBlinker
    setNewQuadAnimationTarget(
        g_leftBlinkerAnimation,
        c_colorBrightGreenR,
        c_colorBrightGreenG,
        c_colorBrightGreenB,
        g_leftBlinker and 255 or 0,
        c_animationDurationShort
    )
end

if g_rightBlinker ~= g_previousRightBlinker then
    g_previousRightBlinker = g_rightBlinker
    setNewQuadAnimationTarget(
        g_rightBlinkerAnimation,
        c_colorBrightGreenR,
        c_colorBrightGreenG,
        c_colorBrightGreenB,
        g_rightBlinker and 255 or 0,
        c_animationDurationShort
    )
end