-- [BRS] - [[Information]]
-- Calls the animate function of ALL the sync required elements.
-- Avoids calling it at all if the state is off.
-- if g_state ~= stateOff then
    -- [BRS] - Speed unit
    animateElement(g_speedUnitLetter1)
    animateElement(g_speedUnitLetter2)
    animateElement(g_speedUnitLetter3)

    -- [BRS] - Vehicle name
    for _,v in pairs(g_vehicleNameElements) do
        animateElement(v)
    end

    animate(g_circleEndAnimation)
    animate(g_circleStartAnimation)
    animate(g_circleOpacity)

    animate(g_backgroundR)
    animate(g_backgroundG)
    animate(g_backgroundB)
    animate(g_backgroundTop)
    animate(g_backgroundBot)

    animate(g_uiSwitch)
-- end