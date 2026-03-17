require("Variables.Animations.timeLeft")
require("Functions.Animations.Framework.setNewAnimationTarget")
require("Projects.Microprocessors.Dashboard.functions.states.stateOff")
require("Projects.Microprocessors.Dashboard.functions.states.booted")
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
function preBootState()
    -- print("state: preBootState")
    ------ Logic
    if g_uiSwitch[c_animationTimeLeft] ~= 0 then
        -- print("preboot waiting")
        return
    end

    if g_subState == 0 then
        g_subState = 1
        g_wantedVehicleNameY = 13
        g_wantedVehicleNameOpacity = 255
        g_wantedBackgroundR = 64
        g_wantedBackgroundG = 50
        g_wantedBackgroundB = 7
        g_wantedBackgroundTop = 0
        g_wantedBackgroundBot = 255
        g_setAnimations = true
        g_wantedUiOpacity = 0
        g_wantedVehicleNameOpacity = 255
        g_wantedCircleStart = c_circleStartHidden
        g_wantedCircleEnd = c_circleEndHidden
        g_wantedUnitY = 32
    end

    ------ NEXT STATE HANDLING -
    if g_playerSensor and g_vehicleOn then -- Boot up state
        g_state = bootedState
        g_subState = 0
    elseif not g_playerSensor then
        g_state = stateOff
        g_subState = 0
    end
end