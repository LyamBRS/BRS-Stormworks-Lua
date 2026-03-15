-- [BRS] - Scripts should be activated as soon as a player is nearby

if g_state == c_stateBooted then
    g_scriptsOn = true
    g_showBooted = true
    g_showPreBoot = false

    if not g_vehicleOn and g_bootedShown then       -- Screen finished booting on
        g_state = c_stateGoToPreboot                -- But the car is turned off... Preboot time
    end
end

-- [BRS] - Shutting down from the booted screen
if g_state == c_stateGoToPreboot then
    g_scriptsOn = true
    g_showBooted = false
    g_showPreBoot = false
    if not g_bootedShown then                       -- Booted screen finished animating down.
        g_state = c_stateOnlyPreboot                -- Start showing the preboot screen
    end

    if g_vehicleOn then                             -- Player turned the car back on...
        g_state = c_stateBooted                     -- Just go to the booted screen.
    end
end

-- [BRS] - Booting up from the preboot screen
if g_state == c_stateGoToBooted then
    g_scriptsOn = true
    g_showBooted = false
    g_showPreBoot = false
    if not g_preBootShown then                      -- Preboot screens stopped showing.
        g_state = c_stateBooted                     -- You can boot up the main screens now
    end

    if not g_vehicleOn then                         -- Player turned it back off
        g_state = c_stateOnlyPreboot                -- Just go back to the preboot screen
    end
end

if g_state == c_stateOnlyPreboot then
    g_scriptsOn = true
    g_showBooted = false
    g_showPreBoot = true

    if not g_playerSensor and g_preBootShown then   -- Player left and the preboot is fully shown now.
        g_state = c_stateOff                        -- Nothing is shown anymore. Everything off!
    end

    if g_vehicleOn and g_preBootShown then          -- Player turned on the vehicle
        g_state = c_stateGoToBooted                 -- Preboot is fully displayed, shut it down
    end
end

if g_state == c_stateOff then
    g_scriptsOn = g_preBootShown or g_bootedShown
    g_showBooted = false
    g_showPreBoot = false

    if g_playerSensor or g_vehicleOn then
        g_state = c_stateOnlyPreboot
    end
end