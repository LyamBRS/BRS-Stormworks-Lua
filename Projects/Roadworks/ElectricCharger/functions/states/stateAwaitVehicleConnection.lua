require("Projects.Roadworks.ElectricCharger.functions.states.stateBootingDown")
require("Projects.Roadworks.ElectricCharger.functions.states.stateMainMenu")
require("Projects.Roadworks.ElectricCharger.functions.states.stateCharger")
require("Projects.Roadworks.ElectricCharger.functions.states.stateInfElectric")
require("Projects.Roadworks.ElectricCharger.functions.outputManagement.innactiveStation")
require("Projects.Roadworks.ElectricCharger.functions.elements.createUIXAnimation")
require("Functions.Animations.Functions.elasticOut")
require("Functions.Animations.Functions.quintInOutAnimation")
require("Functions.Animations.Framework.createAnimation")
require("Variables.Monitor.Elements.surface")
require("Variables.Monitor.Elements.surface.x")
require("Variables.Monitor.Elements.surface.y")
require("Variables.Monitor.Elements.touch")
require("Variables.Monitor.Elements.touch.released")


-- [BRS] - [[ Information ]] --
-- `2025/12/28`
-- ### Description
-- State found inbetween charging / discharging when no vehicles are
-- detected through the radio antenna signal strength.
-- The user is able to go back to the main menu or proceed to charging
-- anyways.
-- ### Used for
-- Prevent the charger from being on forever, trying to charge something
-- that can't be charged.
-- ### State's outputs
-- - Monitor            -> `true`
-- - Cable relay        -> `true`
-- - Antenna relay      -> `true`
-- - Charger relay      -> `false`
-- - Discharger relay   -> `false`
-- - RGB ->
--      - `green`   if vehicle antenna signal == 0
--      - `blue`    if vehicle antenna signal > 0
--      - `red`     if inf electric is detected
-- ### @Input
-- None
-- ### @Returns
-- None
function stateAwaitVehicleConnection()
    -- print("state: main menu")
    direction = g_wantsToCharge and c_mainMenuToDischargeX or c_mainMenuToChargingX

    ------ Logic
    if g_subState == 0 then -- deploy waiting menu
        g_subState = 1
        awayTimer = c_timeToWaitAfterPlayer

        createUIXAnimation(g_awaitVehicleConnectionText, direction, c_textAreaXShown)
        createUIXAnimation(g_noButton, direction, c_buttonXShown)
        createUIXAnimation(g_yesButton, direction, c_buttonXShown)
    end

    -- [BRS] - Count down if no players are detected.
    awayTimer = g_playerSensor and c_timeToWaitAfterPlayer or awayTimer-1

    ------ State outputs
    innactiveStation()

    ------ NEXT STATE HANDLING -
    -- [BRS] - The player cancelled the operation. Back to the main menu.
    g_state = g_noButton[c_elementTouch][c_elementTouchReleased] and stateMainMenu or g_state
    -- [BRS] - The player says they did connect a battery to the charger... we'll take their words for it.
    g_state = g_yesButton[c_elementTouch][c_elementTouchReleased] and stateCharger or g_state
    -- [BRS] - Player left, did nothing AND we waited long enough for them to plug in their cars.
    g_state = awayTimer == 0 and stateBootingDown or g_state
    -- [BRS] - Someone turned on inf electric
    g_state = g_infElectric and stateInfElectric or g_state

    if g_state ~= stateAwaitVehicleConnection then
        g_subState = 0

        -- if we want to charge, the UI direction is flipped.
        if g_state == stateCharger then
            direction = g_wantsToCharge and c_mainMenuToChargingX or c_mainMenuToDischargeX
        end

        setNewAnimationTarget(g_awaitVehicleConnectionText[c_elementSurface][c_elementSurfaceX], direction, c_UIShiftDuration)
        setNewAnimationTarget(g_noButton[c_elementSurface][c_elementSurfaceX], direction, c_UIShiftDuration)
        setNewAnimationTarget(g_yesButton[c_elementSurface][c_elementSurfaceX], direction, c_UIShiftDuration)
    end
end