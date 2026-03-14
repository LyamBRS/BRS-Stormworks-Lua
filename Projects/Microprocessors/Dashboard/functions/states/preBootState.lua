require("Variables.Animations.timeLeft")
require("Functions.Animations.Framework.setNewAnimationTarget")
require("Projects.Microprocessors.Dashboard.functions.states.stateOff")
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
    -- NONE
    ------ State outputs

    ------ NEXT STATE HANDLING -
    if g_playerSensor and g_vehicleOn and g_subState==0 then -- Boot up state
        g_subState = 1
        -- g_state = stateBootingUp

        setNewAnimationTarget(g_speedUnitLetter1[c_elementColors][1][c_elementColorA], 255, 16)
        setNewAnimationTarget(g_speedUnitLetter2[c_elementColors][1][c_elementColorA], 255, 32)
        setNewAnimationTarget(g_speedUnitLetter3[c_elementColors][1][c_elementColorA], 255, 48)
        setNewAnimationTarget(g_speedUnitLetter1[c_elementSurface][c_elementSurfaceY], 21, 16)
        setNewAnimationTarget(g_speedUnitLetter2[c_elementSurface][c_elementSurfaceY], 21, 32)
        setNewAnimationTarget(g_speedUnitLetter3[c_elementSurface][c_elementSurfaceY], 21, 48)

        setNewAnimationTarget(g_circleStartAnimation, c_circleStartShown, 32)
        setNewAnimationTarget(g_circleEndAnimation, c_circleEndShown, 32)
        setNewAnimationTarget(g_circleOpacity, 255, 32)
    elseif not g_playerSensor then
        g_subState = 0
        g_state = stateOff
        setNewAnimationTarget(g_speedUnitLetter1[c_elementColors][1][c_elementColorA], 0, 16)
        setNewAnimationTarget(g_speedUnitLetter2[c_elementColors][1][c_elementColorA], 0, 32)
        setNewAnimationTarget(g_speedUnitLetter3[c_elementColors][1][c_elementColorA], 0, 48)
        setNewAnimationTarget(g_speedUnitLetter1[c_elementSurface][c_elementSurfaceY], 34, 16)
        setNewAnimationTarget(g_speedUnitLetter2[c_elementSurface][c_elementSurfaceY], 34, 32)
        setNewAnimationTarget(g_speedUnitLetter3[c_elementSurface][c_elementSurfaceY], 34, 48)

        setNewAnimationTarget(g_circleStartAnimation, c_circleStartHidden, 32)
        setNewAnimationTarget(g_circleEndAnimation, c_circleEndHidden, 32)
        setNewAnimationTarget(g_circleOpacity, 0, 32)
    end
end