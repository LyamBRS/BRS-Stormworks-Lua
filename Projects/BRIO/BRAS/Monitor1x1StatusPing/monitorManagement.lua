    -- [BRS] - Monitor touch inputs.
    require("Functions.Monitor.onTickVariableGetting")

    -- [BRS] - Arrow buttons.
    require("Projects.BRIO.BRAS.Utils.Monitor1x1.MonitorManagement.arrowButtons")

    -- [BRS] - Button press detection
    pressingPing = PressingInRectangle(0,24,32,8) and not g_onGoing

    -- [BRS] - Managing pressing colors
    pingButton[1] = pingColor
    if pressingPing then SetBothColors(pingButton, pingPressedColor) end

    -- [BRS] - Disabled colors
    pingButton[1] = g_onGoing and disabledColor or pingButton[1]

    -- [BRS] - Text and background colors
    require("Projects.BRIO.BRAS.Utils.Monitor1x1.MonitorManagement.layout")

    -- [BRS] - Lerping the colors towards the wanted ones.
    ColorTableLerp(pingButton, .2)