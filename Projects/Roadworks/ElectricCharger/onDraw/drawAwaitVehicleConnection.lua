    g_cancelButton[c_elementFunction](g_cancelButton)
    g_awaitVehicleConnectionText[c_elementFunction](g_awaitVehicleConnectionText)
    g_okButton[c_elementFunction](g_okButton)

    screen.setColor(64,32,16,240)
    drawTextOnSurface(g_awaitVehicleConnectionTextSurface, " no battery found   Did you connect one?")

    screen.setColor(32,32,32,240)
    drawTextOnSurface(g_cancelButtonSurface, "cancel")

    screen.setColor(0,64,0,240)
    drawTextOnSurface(g_okButtonSurface, "yes")