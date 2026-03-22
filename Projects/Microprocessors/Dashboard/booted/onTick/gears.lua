-- [BRS] - [[ Informations ]]
-- Manages animations for specific gears switchings

if g_previousGears ~= g_gear then
    g_previousGears = g_gear
    yPos = g_gearPosition[c_elementSurfaceY]

    -- [BRS] - Image management
    if g_gear <= c_maximumGearNumber and g_gear >= c_minimumGearNumber then
        g_gearAnimation[c_elementBase64] = {decodeUnicolorImage(property.getText("g"..math.floor(g_gear)))}
        setNewQuadAnimationTarget(
            g_gearColors,
            c_colorGearRegularR,
            c_colorGearRegularG,
            c_colorGearRegularB,
            c_colorGearRegularA,
            c_durationGearY
        )

        -- [BRS] - Position & color management
        if g_gear == c_gearPark then
            setNewAnimationTarget(yPos, c_gearsPositionMiddleY, c_durationGearY)
            setNewAnimationTarget(g_speedUnitLetter1Color[4], 0, c_animationDurationShortest)
            setNewAnimationTarget(g_speedUnitLetter2Color[4], 0, c_animationDurationShort)
            setNewAnimationTarget(g_speedUnitLetter3Color[4], 0, c_animationDurationNormal)
            setNewAnimationTarget(g_speedUnitLetter1Positions[2], c_speedUnitHiddenY, c_animationDurationShortest)
            setNewAnimationTarget(g_speedUnitLetter2Positions[2], c_speedUnitHiddenY, c_animationDurationShort)
            setNewAnimationTarget(g_speedUnitLetter3Positions[2], c_speedUnitHiddenY, c_animationDurationNormal)
        else
            setNewAnimationTarget(yPos, c_gearsPositionTopY, c_durationGearY)
            setNewAnimationTarget(g_speedUnitLetter1Color[4], 200, c_animationDurationShortest)
            setNewAnimationTarget(g_speedUnitLetter2Color[4], 200, c_animationDurationShort)
            setNewAnimationTarget(g_speedUnitLetter3Color[4], 200, c_animationDurationNormal)
            setNewAnimationTarget(g_speedUnitLetter1Positions[2], c_speedUnitShownY, c_animationDurationShortest)
            setNewAnimationTarget(g_speedUnitLetter2Positions[2], c_speedUnitShownY, c_animationDurationShort)
            setNewAnimationTarget(g_speedUnitLetter3Positions[2], c_speedUnitShownY, c_animationDurationNormal)
        end
    else
        setNewQuadAnimationTarget(
            g_gearColors,
            c_colorGearOffR,
            c_colorGearOffG,
            c_colorGearOffB,
            c_colorGearOffA,
            c_durationGearY
        )
        setNewAnimationTarget(yPos, c_gearsPositionMiddleY, c_durationGearY)
        setNewAnimationTarget(g_speedUnitLetter1Color[4], 0, c_animationDurationShortest)
        setNewAnimationTarget(g_speedUnitLetter2Color[4], 0, c_animationDurationShort)
        setNewAnimationTarget(g_speedUnitLetter3Color[4], 0, c_animationDurationNormal)
        setNewAnimationTarget(g_speedUnitLetter1Positions[2], c_speedUnitHiddenY, c_animationDurationShortest)
        setNewAnimationTarget(g_speedUnitLetter2Positions[2], c_speedUnitHiddenY, c_animationDurationShort)
        setNewAnimationTarget(g_speedUnitLetter3Positions[2], c_speedUnitHiddenY, c_animationDurationNormal)
    end
end