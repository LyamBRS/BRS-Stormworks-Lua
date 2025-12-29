require("Projects.Roadworks.ElectricCharger.functions.states.stateBootingDown")
require("Projects.Roadworks.ElectricCharger.functions.states.stateMainMenu")
require("Projects.Roadworks.ElectricCharger.functions.stationLight.stationLightWhenInnactive")
require("Functions.Animations.Framework.elasticOut")
require("Functions.Animations.Framework.quintInOutAnimation")
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

        g_awaitVehicleConnectionTextSurface[c_elementSurfaceX] = createAnimation(
            direction,
            c_textAreaXShown,
            80,
            quintInOutAnimation
        )

        g_cancelButtonSurface[c_elementSurfaceX] = createAnimation(
            direction,
            c_buttonXShown,
            80,
            quintInOutAnimation
        )

        g_okButtonSurface[c_elementSurfaceX] = createAnimation(
            direction,
            c_buttonXShown,
            80,
            quintInOutAnimation
        )
    end

    -- [BRS] - Count down if no players are detected.
    awayTimer = g_playerSensor and c_timeToWaitAfterPlayer or awayTimer-1

    ------ State outputs
    g_monitorState = true
    g_relayAntenna = true
    g_relayCharger = false
    g_relayDischarger = false
    stationLightWhenInnactive()

    ------ NEXT STATE HANDLING -
    -- [BRS] - The signal strength detected something! The player connected their vehicle.

    -- [BRS] - The player cancelled the operation. Back to the main menu.
    if g_cancelButton[c_elementTouch][c_elementTouchReleased] then
        g_subState = 0
        g_state = stateMainMenu
        setNewAnimationTarget(g_awaitVehicleConnectionTextSurface[c_elementSurfaceX], direction, 80, quintInOutAnimation)
        setNewAnimationTarget(g_cancelButtonSurface[c_elementSurfaceX], direction, 80, quintInOutAnimation)
        setNewAnimationTarget(g_okButtonSurface[c_elementSurfaceX], direction, 80, quintInOutAnimation)
    end

    -- [BRS] - Player left, did nothing AND we waited long enough for them to plug in their cars.
    if awayTimer == 0 then
        g_subState = 0
        g_state = stateBootingDown
        setNewAnimationTarget(g_awaitVehicleConnectionTextSurface[c_elementSurfaceX], direction, 80, elasticOutAnimation)
        setNewAnimationTarget(g_cancelButtonSurface[c_elementSurfaceX], direction, 80, elasticOutAnimation)
        setNewAnimationTarget(g_okButtonSurface[c_elementSurfaceX], direction, 80, elasticOutAnimation)
    end
end