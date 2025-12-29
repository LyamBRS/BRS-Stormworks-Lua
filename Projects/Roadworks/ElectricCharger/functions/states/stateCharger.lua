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
-- Actual charging and discharge state.
-- If the electric store stays the same for 60 ticks, it'll assess if it
-- was a successful charging session or not.
-- ### Used for
-- Actually charging the vehicle that's connected to the station.
-- ### State's outputs
-- - Monitor            -> `true`
-- - Antenna relay      -> `true`
-- - Charger relay      -> `false` | `true`
-- - Discharger relay   -> `false` | `true`
-- - RGB ->
--      - `green`   if vehicle antenna signal == 0
--      - `blue`    if vehicle antenna signal > 0
--      - `red`     if inf electric is detected
-- ### @Input
-- None
-- ### @Returns
-- None
function stateCharger()
    -- print("state: stateCharger")
    direction = g_wantsToCharge and c_mainMenuToDischargeX or c_mainMenuToChargingX

    ------ Logic
    if g_subState == 0 then -- deploy waiting menu
        g_subState = 1

        g_chargingVehicleTextSurface[c_elementSurfaceX] = createAnimation(
            direction,
            c_textAreaXShown,
            c_UIShiftDuration,
            quintInOutAnimation
        )

        g_cancelChargingButtonSurface[c_elementSurfaceX] = createAnimation(
            direction,
            c_buttonXShown,
            c_UIShiftDuration,
            quintInOutAnimation
        )
    end

    ------ State outputs
    g_monitorState = true
    g_relayAntenna = true
    g_relayCharger = g_wantsToCharge
    g_relayDischarger = not g_wantsToCharge
    stationLightWhenInnactive()

    ------ NEXT STATE HANDLING -
    -- [BRS] - The signal strength detected something! The player connected their vehicle.

    -- [BRS] - The player cancelled the operation. Back to the main menu.
    if g_cancelChargingButton[c_elementTouch][c_elementTouchReleased] then
        g_subState = 0
        g_state = stateMainMenu
        setNewAnimationTarget(g_chargingVehicleTextSurface[c_elementSurfaceX], direction, c_UIShiftDuration)
        setNewAnimationTarget(g_cancelChargingButtonSurface[c_elementSurfaceX], direction, c_UIShiftDuration)
    end
end