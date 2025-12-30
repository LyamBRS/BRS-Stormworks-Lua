    g_batteryChargeBarBotSurface = g_batteryChargeBarBot[c_elementSurface]
    
    g_cancelChargingButton[c_elementFunction](g_cancelChargingButton)
    g_chargingVehicleText[c_elementFunction](g_chargingVehicleText)
    g_batteryChargeBarBot[c_elementFunction](g_batteryChargeBarBot)
    g_batteryChargeBarTop[c_elementFunction](g_batteryChargeBarTop)

    red = g_wantsToCharge and 16 or 70
    green = g_wantsToCharge and 70 or 16
    screen.setColor(red,green,0,220)
    suffix = g_wantsToCharge and "charging" or "    discharging  "
    drawTextOnSurface(g_chargingVehicleText[c_elementSurface], suffix.." vehicle")

    green = g_electricStore * 255
    red = 255 - green
    screen.setColor(red, green, 0, 128)
    drawTextOnSurface(g_batteryChargeBarBotSurface, string.format("%.2f", g_electricStore*100).."%")

    -- Session timer
    totalSeconds = math.floor(g_currentSessionTimer / 60)
    minutes = math.floor(totalSeconds / 60)
    seconds = totalSeconds % 60

    screen.setColor(128,0,255,128)
    screen.drawTextBox(
        g_batteryChargeBarBotSurface[c_elementSurfaceX][c_animationCurrent],
        g_batteryChargeBarBotSurface[c_elementSurfaceY][c_animationCurrent] - 11,
        g_batteryChargeBarBotSurface[c_elementSurfaceW][c_animationCurrent],
        g_batteryChargeBarBotSurface[c_elementSurfaceH][c_animationCurrent],
        string.format("%02d:%02d", minutes, seconds),
        0,
        0
    )