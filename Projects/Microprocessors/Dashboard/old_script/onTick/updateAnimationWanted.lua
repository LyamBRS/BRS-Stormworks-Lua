if g_setAnimations == true then
    g_setAnimations = false

    -- print("UPDATED THO")

    setNewAnimationTarget(g_uiSwitch, g_uiSwitch[c_animationCurrent]-1, 32, lerpAnimation)

    -- [BRS] - Letters
    time = math.floor(32 / #g_vehicleNameElements)
    for i=1, #g_vehicleNameElements do
        letter = g_vehicleNameElements[i]
        setNewAnimationTarget(letter[c_elementSurface][c_elementSurfaceY], g_wantedVehicleNameY, time * i)
        setNewAnimationTarget(letter[c_elementColors][1][c_elementColorA], g_wantedVehicleNameOpacity, time * i)
    end

    -- [BRS] - Backgrounds
    setNewAnimationTarget(g_backgroundR, g_wantedBackgroundR, 32)
    setNewAnimationTarget(g_backgroundG, g_wantedBackgroundG, 32)
    setNewAnimationTarget(g_backgroundB, g_wantedBackgroundB, 32)
    setNewAnimationTarget(g_backgroundTop, g_wantedBackgroundTop, 32)
    setNewAnimationTarget(g_backgroundBot, g_wantedBackgroundBot, 32)

    -- [BRS] - Speed unit
    setNewAnimationTarget(g_speedUnitLetter1[c_elementColors][1][c_elementColorA], g_wantedUiOpacity, 16)
    setNewAnimationTarget(g_speedUnitLetter2[c_elementColors][1][c_elementColorA], g_wantedUiOpacity, 32)
    setNewAnimationTarget(g_speedUnitLetter3[c_elementColors][1][c_elementColorA], g_wantedUiOpacity, 48)
    setNewAnimationTarget(g_speedUnitLetter1[c_elementSurface][c_elementSurfaceY], g_wantedUnitY, 16)
    setNewAnimationTarget(g_speedUnitLetter2[c_elementSurface][c_elementSurfaceY], g_wantedUnitY, 32)
    setNewAnimationTarget(g_speedUnitLetter3[c_elementSurface][c_elementSurfaceY], g_wantedUnitY, 48)

    -- [BRS] - Speed dial
    setNewAnimationTarget(g_circleStartAnimation, g_wantedCircleStart, 32)
    setNewAnimationTarget(g_circleEndAnimation, g_wantedCircleEnd, 32)
    setNewAnimationTarget(g_circleOpacity, g_wantedUiOpacity, 32)
end