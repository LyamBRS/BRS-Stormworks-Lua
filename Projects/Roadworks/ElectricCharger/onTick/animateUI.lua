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
    animate(g_chargeButton[c_elementSurface][c_elementSurfaceX])
    animate(g_infoButton[c_elementSurface][c_elementSurfaceX])
    animate(g_dischargeButton[c_elementSurface][c_elementSurfaceX])
    animate(g_chargeButton[c_elementColors][1][c_elementColorA])
    animate(g_chargeButton[c_elementColors][2][c_elementColorA])
    animate(g_dischargeButton[c_elementColors][1][c_elementColorA])
    animate(g_dischargeButton[c_elementColors][2][c_elementColorA])
    animate(g_infoButton[c_elementColors][1][c_elementColorA])
    animate(g_infoButton[c_elementColors][2][c_elementColorA])
end