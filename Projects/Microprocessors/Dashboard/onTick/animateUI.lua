-- [BRS] - [[Information]]
-- Calls the animate function of ALL the sync required elements.
-- Avoids calling it at all if the state is off.
-- if g_state ~= stateOff then
    -- [BRS] - Logo animations
    animateElement(g_speedUnitLetter1)
    animateElement(g_speedUnitLetter2)
    animateElement(g_speedUnitLetter3)

    animate(g_circleEndAnimation)
    animate(g_circleStartAnimation)
    animate(g_circleOpacity)
-- end