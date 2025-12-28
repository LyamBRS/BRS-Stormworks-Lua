-- [BRS] - [[Minifications]]
-- 214 characters used here.
if g_state == stateMainMenu or g_state==stateBootingDown then
    g_chargeButton[c_elementFunction](g_chargeButton)
    g_dischargeButton[c_elementFunction](g_dischargeButton)
    g_infoButton[c_elementFunction](g_infoButton)
    g_mainMenuText[c_elementFunction](g_mainMenuText)

    screen.setColor(0,32,0,240)
    drawTextOnSurface(g_chargeButtonSurface, "charge")

    screen.setColor(32,0,0,240)
    drawTextOnSurface(g_dischargeButtonSurface, "discharge")

    screen.setColor(0,0,32,240)
    drawTextOnSurface(g_infoButtonSurface, "information")

    screen.setColor(16,32,32,240)
    drawTextOnSurface(g_mainMenuTextSurface, " what do you wish to do?")
end