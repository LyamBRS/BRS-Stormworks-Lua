require("Projects.Roadworks.ElectricCharger.functions.states.stateInfElectric")
require("Projects.Roadworks.ElectricCharger.functions.states.stateBootingDown")
require("Projects.Roadworks.ElectricCharger.functions.states.stateMainMenu")
require("Projects.Roadworks.ElectricCharger.functions.states.bootingStateLogic")
require("Projects.Roadworks.ElectricCharger.functions.outputManagement.innactiveStation")
require("Variables.Monitor.Elements.touch")
require("Variables.Monitor.Elements.touch.released")
-- [BRS] - [[ Information ]] --
-- `2025/12/30`
-- ### Description
-- The electric charger's "you finished charging" screen, which eventually
-- boots off if the player left for long enough.
-- ### Used for
-- Telling the player that they finished charging or discharging their
-- vehicle.
-- ### State's outputs
-- - Monitor            -> `true`
-- - Cable relay        -> `true`
-- - Antenna relay      -> `true`
-- - Charger relay      -> `false`
-- - Discharger relay   -> `false`
-- - RGB ->
--      - `green`   if vehicle antenna signal == 0
--      - `yellow`  if vehicle antenna signal > 0
--      - `red`     if inf electric is detected
-- ### @Input
-- None
-- ### @Returns
-- None
function stateFinishedSession()
    -- print("state: finished session")
    ------ Logic
    direction = g_wantsToCharge and c_mainMenuToDischargeX or c_mainMenuToChargingX

    ------ Logic
    if g_subState == 0 then -- deploy menu
        g_subState = 1
        g_timeBeforeBootOff = c_timeToWaitAfterPlayer

        -- Flip the direction when the UI appears.
        direction = g_wantsToCharge and c_mainMenuToChargingX or c_mainMenuToDischargeX

        createUIXAnimation(g_finishedSessionText, direction, c_textAreaXShown)
        createUIXAnimation(g_okFinishedSessionButton, direction, c_buttonXShown)
        createUIXAnimation(g_finishedSessionTime, direction, c_buttonXShown)
    end

    -- wait for boot off
    g_timeBeforeBootOff = g_playerSensor and c_timeToWaitAfterPlayer or g_timeBeforeBootOff-1

    ------ State outputs
    innactiveStation()

    ------ NEXT STATE HANDLING -
    g_state = g_okFinishedSessionButton[c_elementTouch][c_elementTouchReleased] and stateMainMenu or g_state
    g_state = g_timeBeforeBootOff==0 and stateBootingDown or g_state

    if g_state ~= stateFinishedSession then
        g_subState = 0

        -- if we want to charge, the UI direction is flipped.
        setNewAnimationTarget(g_finishedSessionText[c_elementSurface][c_elementSurfaceX], direction, c_UIShiftDuration)
        setNewAnimationTarget(g_okFinishedSessionButton[c_elementSurface][c_elementSurfaceX], direction, c_UIShiftDuration)
        setNewAnimationTarget(g_finishedSessionTime[c_elementSurface][c_elementSurfaceX], direction, c_UIShiftDuration)
    end
end