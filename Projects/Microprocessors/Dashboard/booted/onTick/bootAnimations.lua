-- [BRS] - [[ Informations ]]
-- Here is managed the booting animation of the booted screen.
-- Updated only when the manager changes the wanted UI display.

if g_showUI ~= g_previousShowUI then
    g_previousShowUI = g_showUI

    if g_showUI then
        setNewQuadAnimationTarget(
            g_speedDialRadiansAnimations,
            c_circleStartShown,
            c_circleEndShown,
            0,
            0,
            c_durationSpeedDialRadianBooted
        )

        setNewQuadAnimationTarget(
            g_speedDialInnerColorAnimations,
            c_colorSpeedDialRegularBotR,
            c_colorSpeedDialRegularBotG,
            c_colorSpeedDialRegularBotB,
            c_colorSpeedDialRegularBotA,
            c_durationSpeedDialColorsBooted
        )

        setNewQuadAnimationTarget(
            g_speedDialOuterColorAnimations,
            c_colorSpeedDialRegularTopR,
            c_colorSpeedDialRegularTopG,
            c_colorSpeedDialRegularTopB,
            c_colorSpeedDialRegularTopA,
            c_durationSpeedDialColorsBooted
        )
        setNewAnimationTarget(g_uiShownAnimation, 1, c_animationDurationLongest)
    else
        setNewQuadAnimationTarget(
            g_speedDialRadiansAnimations,
            c_circleStartHidden,
            c_circleEndHidden,
            0,
            0,
            c_durationSpeedDialRadianPreBoot
        )

        setNewQuadAnimationTarget(
            g_speedDialInnerColorAnimations,0,0,0,0,
            c_durationSpeedDialColorsPreBoot
        )

        setNewQuadAnimationTarget(
            g_speedDialOuterColorAnimations,0,0,0,0,
            c_durationSpeedDialColorsPreBoot
        )
        setNewAnimationTarget(g_uiShownAnimation, 0, c_animationDurationLongest)
    end
end