-- [BRS] - Detecting changes
if g_managerState ~= g_previousState then
    g_previousState = g_managerState

    if g_managerState == c_stateGoToBooted then
        setNewQuadAnimationTarget(
            g_topColorAnimation,
            c_colorBackgroundGradiantTopBootedR,
            c_colorBackgroundGradiantTopBootedG,
            c_colorBackgroundGradiantTopBootedB,
            c_colorBackgroundGradiantTopBootedA,
            c_durationToBoot
        )

        setNewQuadAnimationTarget(
            g_botColorAnimation,
            c_colorBackgroundGradiantBotBootedR,
            c_colorBackgroundGradiantBotBootedG,
            c_colorBackgroundGradiantBotBootedB,
            c_colorBackgroundGradiantBotBootedA,
            c_durationToBoot
        )

        setNewQuadAnimationTarget(
            g_fullColorAnimation,
            c_colorBackgroundFullBootedR,
            c_colorBackgroundFullBootedG,
            c_colorBackgroundFullBootedB,
            c_colorBackgroundFullBootedA,
            c_durationToBoot
        )

    elseif g_managerState == c_stateGoToPreboot then
        setNewQuadAnimationTarget(
            g_topColorAnimation,
            c_colorBackgroundGradiantTopPreBootR,
            c_colorBackgroundGradiantTopPreBootG,
            c_colorBackgroundGradiantTopPreBootB,
            c_colorBackgroundGradiantTopPreBootA,
            c_durationFromBoot
        )

        setNewQuadAnimationTarget(
            g_botColorAnimation,
            c_colorBackgroundGradiantBotPreBootedR,
            c_colorBackgroundGradiantBotPreBootedG,
            c_colorBackgroundGradiantBotPreBootedB,
            c_colorBackgroundGradiantBotPreBootedA,
            c_durationFromBoot
        )

        setNewQuadAnimationTarget(
            g_fullColorAnimation,
            c_colorBackgroundFullPreBootR,
            c_colorBackgroundFullPreBootG,
            c_colorBackgroundFullPreBootB,
            c_colorBackgroundFullPreBootA,
            c_durationFromBoot
        )

    elseif g_managerState == c_stateOnlyPreboot then
        setNewQuadAnimationTarget(
            g_topColorAnimation,
            c_colorBackgroundGradiantTopPreBootR,
            c_colorBackgroundGradiantTopPreBootG,
            c_colorBackgroundGradiantTopPreBootB,
            c_colorBackgroundGradiantTopPreBootA,
            c_durationFromOff
        )

        setNewQuadAnimationTarget(
            g_botColorAnimation,
            c_colorBackgroundGradiantBotPreBootedR,
            c_colorBackgroundGradiantBotPreBootedG,
            c_colorBackgroundGradiantBotPreBootedB,
            c_colorBackgroundGradiantBotPreBootedA,
            c_durationFromOff
        )

        setNewQuadAnimationTarget(
            g_fullColorAnimation,
            c_colorBackgroundFullPreBootR,
            c_colorBackgroundFullPreBootG,
            c_colorBackgroundFullPreBootB,
            c_colorBackgroundFullPreBootA,
            c_durationFromOff
        )

    elseif g_managerState == c_stateOff then
        setNewQuadAnimationTarget(
            g_topColorAnimation,
            0,0,0,255,
            c_durationToOff
        )

        setNewQuadAnimationTarget(
            g_botColorAnimation,
            0,0,0,255,
            c_durationToOff
        )

        setNewQuadAnimationTarget(
            g_fullColorAnimation,
            0,0,0,255,
            c_durationToOff
        )

        setNewQuadAnimationTarget(
            g_positionAnimation,
            0,0,c_monitorWidth,c_monitorHeight,
            c_durationToOff
        )
    end
end