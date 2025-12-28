-- [BRS] - [[Information]]
-- Calls the animate function of ALL the sync required elements.
-- Avoids calling it at all if the state is off.
if g_state ~= stateOff then
    -- [BRS] - Logo animations
    animate(brsLogoBY)
    animate(brsLogoRY)
    animate(brsLogoSY)
    animate(brsLogoSweep)

    -- [BRS] - Boot monitor fade animations
    animate(bootFadeAlphaBot)
    animate(bootFadeAlphaTop)

    -- [BRS] - Main menu animations
    animate(g_chargeButtonSurface[c_elementSurfaceX])
    animate(g_chargeButton[c_elementColors][1][c_elementColorA])
    animate(g_chargeButton[c_elementColors][2][c_elementColorA])
    animate(g_dischargeButtonSurface[c_elementSurfaceX])
    animate(g_dischargeButton[c_elementColors][1][c_elementColorA])
    animate(g_dischargeButton[c_elementColors][2][c_elementColorA])
    animate(g_infoButtonSurface[c_elementSurfaceX])
    animate(g_infoButton[c_elementColors][1][c_elementColorA])
    animate(g_infoButton[c_elementColors][2][c_elementColorA])
    animate(g_mainMenuTextSurface[c_elementSurfaceY])
    animate(g_mainMenuTextSurface[c_elementSurfaceX])

    -- [BRS] - Await vehicle connection animations
    animate(g_cancelButtonSurface[c_elementSurfaceX])
    animate(g_cancelButton[c_elementColors][1][c_elementColorA])
    animate(g_cancelButton[c_elementColors][2][c_elementColorA])
    animate(g_awaitVehicleConnectionTextSurface[c_elementSurfaceX])
    animate(g_okButtonSurface[c_elementSurfaceX])
    animate(g_okButton[c_elementColors][1][c_elementColorA])
    animate(g_okButton[c_elementColors][2][c_elementColorA])
end