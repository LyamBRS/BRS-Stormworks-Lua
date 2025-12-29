    g_cancelChargingButton[c_elementFunction](g_cancelChargingButton)
    g_chargingVehicleText[c_elementFunction](g_chargingVehicleText)
    g_batteryChargeBarTop[c_elementFunction](g_batteryChargeBarTop)
    g_batteryChargeBarBot[c_elementFunction](g_batteryChargeBarBot)

    screen.setColor(64,32,16,240)
    suffix = g_wantsToCharge and "charging" or "    discharging  "
    drawTextOnSurface(g_chargingVehicleText[c_elementSurface], suffix.." vehicle")