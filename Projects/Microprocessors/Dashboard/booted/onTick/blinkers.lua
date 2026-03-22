if g_leftBlinker ~= g_previousLeftBlinker then
    g_previousLeftBlinker = g_leftBlinker
    setNewQuadAnimationTarget(
        g_leftBlinkerAnimation,
        c_colorBrightGreenR,
        c_colorBrightGreenG,
        c_colorBrightGreenB,
        g_leftBlinker and 255 or 0,
        g_leftBlinker and 0 or c_animationDurationShort
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
        g_rightBlinker and 0 or c_animationDurationShort
    )
end

if g_hazards ~= g_previousHazards then
    g_previousHazards = g_hazards
    setNewQuadAnimationTarget(
        g_hazardTriangleColors,
        c_colorBrightRedR,
        c_colorBrightRedG,
        c_colorBrightRedB,
        g_hazards and 255 or 0,
        g_hazards and 0 or c_animationDurationShort
    )
end