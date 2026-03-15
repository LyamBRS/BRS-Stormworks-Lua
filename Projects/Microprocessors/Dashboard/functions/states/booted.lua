require("Projects.Microprocessors.Dashboard.functions.states.preBootState")
-- [BRS] - [[ Information ]] --
-- `2026/03/14`
-- ### Description
-- In this state, the dashboard waits for the screen to show the
-- off data, allowing the user to boot it up afterwards.
-- in this state you can show if stuff is locked for example.
-- ### Used for
-- Waiting after the user to boot up the dashboard
-- ### @Input
-- None
-- ### @Returns
-- None
function bootedState()
    -- print("state: booted")
    ------ Logic
    if g_uiSwitch[c_animationTimeLeft] ~= 0 then
        -- print("booted waiting")
        return
    end
    ------ State outputs

    ------ NEXT STATE HANDLING -
    if g_subState == 1 then
        g_subState = 2
        g_wantedUiOpacity = 255
        g_wantedCircleStart = c_circleStartShown
        g_wantedCircleEnd = c_circleEndShown
        g_wantedUnitY = 21
        g_setAnimations = true
    end

    if g_subState == 0 then
        g_subState = 1
        g_wantedVehicleNameOpacity = 0
        g_wantedVehicleNameY = -5
        g_wantedBackgroundR = 62
        g_wantedBackgroundG = 54
        g_wantedBackgroundB = 41
        g_wantedBackgroundTop = 255
        g_wantedBackgroundBot = 0
        g_setAnimations = true
    end

    if not g_vehicleOn then -- Boot up state
        g_state = preBootState
        g_subState = 0
    end
end