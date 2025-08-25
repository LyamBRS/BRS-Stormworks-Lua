    -- [BRS] - Monitor touch inputs.
    require("Functions.Monitor.onTickVariableGetting")

    -- [BRS] - Arrow buttons.
    require("Projects.BRIO.BRAS.Monitor1x1.MonitorManagement.arrowButtons")

    -- [BRS] - Button press detection
    pressingOpen = PressingInRectangle(0,24,14,8) and not g_onGoing
    pressingClose = PressingInRectangle(18,24,14,8) and not g_onGoing

    -- [BRS] - Managing pressing colors
    openButton[1] = openColor
    closeButton[1] = closeColor
    if pressingOpen then SetBothColors(openButton, openPressedColor) end
    if pressingClose then SetBothColors(closeButton, closePressedColor) end

    -- [BRS] - Disabled colors
    openButton[1] = g_onGoing and disabledColor or openButton[1]
    closeButton[1] = g_onGoing and disabledColor or closeButton[1]

    -- [BRS] - Text and background colors
    require("Projects.BRIO.BRAS.Monitor1x1.MonitorManagement.layout")

    -- [BRS] - Lerping the colors towards the wanted ones.
    ColorTableLerp(openButton, .2)
    ColorTableLerp(closeButton, .2)