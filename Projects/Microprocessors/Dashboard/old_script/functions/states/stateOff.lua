require("Projects.Microprocessors.Dashboard.functions.states.preBootState")
-- [BRS] - [[ Information ]] --
-- `2026/03/14`
-- ### Description
-- The dashboard's onTick "off" state of its state machine
-- In this state, everything is off and onTick attempts to finish
-- as soon as possible.
-- This state goes to the `bootOn` state if the player sensor
-- is detected.
-- ### Used for
-- Keeping the whole system offline and save as much ressources
-- as humanly possible.
-- ### @Input
-- None
-- ### @Returns
-- None
function stateOff()
    -- print("state: off")
    ------ Logic
    if g_uiSwitch[c_animationTimeLeft] ~= 0 then
        -- print("off waiting")
        return
    end
    ------ State outputs
    g_monitorState = false

    ------ NEXT STATE HANDLING -
    if g_playerSensor then
        g_subState = 0
        g_monitorDelayCounter = 0
        g_monitorState = true
        g_state = preBootState
    else
        g_monitorDelayCounter = g_monitorDelayCounter + 1
        if g_monitorDelayCounter > 10 then
            g_monitorState = false
            g_monitorDelayCounter = 10
        end

        if g_subState == 0 then
            g_subState = 1
            g_wantedUiOpacity = 0
            g_wantedVehicleNameOpacity = 0
            g_wantedCircleStart = c_circleStartHidden
            g_wantedCircleEnd = c_circleEndHidden
            g_wantedVehicleNameY = 32
            g_wantedBackgroundR = 64
            g_wantedBackgroundG = 50
            g_wantedBackgroundB = 7
            g_wantedBackgroundTop = 0
            g_wantedBackgroundBot = 0
            g_setAnimations = true
        end
    end
end

g_monitorDelayCounter = 0