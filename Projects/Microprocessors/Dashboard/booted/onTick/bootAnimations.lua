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
            c_durationSpeedDialColorsBooted
        )

        setNewQuadAnimationTarget(
            g_speedDialInnerColorAnimations,
            c_circleStartShown,
            c_circleEndShown,
            0,
            0,
            c_durationSpeedDialColorsBooted
        )
    else

    end
end


c_circleEndShown = 3.93
c_circleStartShown = -.79
c_circleEndHidden = -.79
c_circleStartHidden = -2.79