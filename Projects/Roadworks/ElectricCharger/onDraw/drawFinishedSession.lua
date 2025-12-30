    g_okFinishedSessionButton[c_elementFunction](g_okFinishedSessionButton)
    g_finishedSessionText[c_elementFunction](g_finishedSessionText)

    -- [BRS] - red and green colors are defined already in `drawChargingVehicle`
    screen.setColor(red,green,0,220)
    suffix = g_wantsToCharge and "charging" or "discharging"
    drawTextOnSurface(g_finishedSessionText[c_elementSurface], "finished "..suffix)

    -- [BRS] - minutes and seconds are already calculated in `drawChargingVehicle`
    screen.setColor(128,0,255,128)
    drawTextOnSurface(g_finishedSessionTime[c_elementSurface], timerText)