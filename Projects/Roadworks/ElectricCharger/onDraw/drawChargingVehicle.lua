    g_cancelChargingButton[c_elementFunction](g_cancelChargingButton)
    g_chargingVehicleText[c_elementFunction](g_chargingVehicleText)

    screen.setColor(64,32,16,240)
    suffix = g_wantsToCharge and "charging" or "    discharging  "
    drawTextOnSurface(g_chargingVehicleTextSurface, suffix.." vehicle")

    screen.setColor(32,32,32,240)
    drawTextOnSurface(g_cancelChargingButtonSurface, "cancel")