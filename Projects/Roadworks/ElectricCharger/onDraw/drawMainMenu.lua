if g_state == stateMainMenu or g_state==stateBootingDown then
    g_chargeButton[c_elementFunction](g_chargeButton)
    g_dischargeButton[c_elementFunction](g_dischargeButton)
    g_infoButton[c_elementFunction](g_infoButton)

    screen.setColor(0,32,0,240)
    screen.drawTextBox(
        g_chargeButton[c_elementSurface][c_elementSurfaceX][c_animationCurrent],
        g_chargeButton[c_elementSurface][c_elementSurfaceY][c_animationCurrent],
        g_chargeButton[c_elementSurface][c_elementSurfaceW][c_animationCurrent],
        g_chargeButton[c_elementSurface][c_elementSurfaceH][c_animationCurrent],
        "charge",
        0,
        0
    )

    screen.setColor(32,0,0,240)
    screen.drawTextBox(
        g_dischargeButton[c_elementSurface][c_elementSurfaceX][c_animationCurrent],
        g_dischargeButton[c_elementSurface][c_elementSurfaceY][c_animationCurrent],
        g_dischargeButton[c_elementSurface][c_elementSurfaceW][c_animationCurrent],
        g_dischargeButton[c_elementSurface][c_elementSurfaceH][c_animationCurrent],
        "discharge",
        0,
        0
    )

    screen.setColor(0,0,32,240)
    screen.drawTextBox(
        g_infoButton[c_elementSurface][c_elementSurfaceX][c_animationCurrent],
        g_infoButton[c_elementSurface][c_elementSurfaceY][c_animationCurrent],
        g_infoButton[c_elementSurface][c_elementSurfaceW][c_animationCurrent],
        g_infoButton[c_elementSurface][c_elementSurfaceH][c_animationCurrent],
        "information",
        0,
        0
    )
end