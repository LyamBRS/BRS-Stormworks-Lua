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
    animateElement(g_chargeButton)
    animateElement(g_dischargeButton)
    animateElement(g_infoButton)
    animateElement(g_mainMenuText)

    -- -- [BRS] - Await vehicle connection animations
    animateElement(g_cancelButton)
    animateElement(g_okButton)
    animateElement(g_awaitVehicleConnectionText)

    -- -- [BRS] - Charging / discharging vehicle
    animateElement(g_cancelChargingButton)
    animateElement(g_chargingVehicleText)
    animateElement(g_batteryChargeBarTop)
    animateElement(g_batteryChargeBarBot)
end