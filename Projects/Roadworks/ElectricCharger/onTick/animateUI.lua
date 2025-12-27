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
end