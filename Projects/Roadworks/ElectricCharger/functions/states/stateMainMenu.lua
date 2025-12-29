require("Projects.Roadworks.ElectricCharger.functions.states.stateBootingDown")
require("Projects.Roadworks.ElectricCharger.functions.states.stateAwaitVehicleConnection")
require("Projects.Roadworks.ElectricCharger.functions.states.stateCharger")
require("Projects.Roadworks.ElectricCharger.functions.stationLight.stationLightWhenInnactive")
require("Functions.Animations.Framework.elasticOut")
require("Functions.Animations.Framework.quintInOutAnimation")
require("Variables.Monitor.Elements.surface")
require("Variables.Monitor.Elements.surface.x")
require("Variables.Monitor.Elements.surface.y")
require("Variables.Monitor.Elements.touch")
require("Variables.Monitor.Elements.touch.released")

-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- The electric charger's main menu state.
-- Animates its appearance then either waits for the player to leave
-- or for the player to click on one of its buttons.
-- ### Used for
-- Allowing the user to select what they want the charging station to
-- do.
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
function stateMainMenu()
    -- print("state: main menu")
    ------ Logic
    if g_subState == 0 then -- deploy main menu
        setNewAnimationTarget(g_chargeButtonSurfaceX, c_buttonXShown, c_UIShiftDuration)
        setNewAnimationTarget(g_infoButtonSurfaceX, c_buttonXShown, c_UIShiftDuration)
        setNewAnimationTarget(g_dischargeButtonSurfaceX, c_buttonXShown, c_UIShiftDuration)
        setNewAnimationTarget(g_mainMenuText[c_elementSurface][c_elementSurfaceY], c_textAreaYShown, 40)
        setNewAnimationTarget(g_mainMenuTextSurfaceX, c_textAreaXShown, c_UIShiftDuration)
        g_subState = 1
    end

    ------ State outputs
    g_monitorState = true
    g_relayAntenna = true
    g_relayCharger = false
    g_relayDischarger = false
    stationLightWhenInnactive()

    ------ NEXT STATE HANDLING -
    if g_playerSensor == false then
        -- [BRS] - Player left and did nothing. Boot off.
        g_state = stateBootingDown
        g_subState = 0
        setNewAnimationTarget(g_chargeButtonSurfaceX, c_chargeButtonXHidden, 80, elasticOutAnimation)
        setNewAnimationTarget(g_infoButtonSurfaceX, c_infoButtonXHidden, 80, elasticOutAnimation)
        setNewAnimationTarget(g_dischargeButtonSurfaceX, c_dischargeButtonXHidden, 80, elasticOutAnimation)
        setNewAnimationTarget(g_mainMenuText[c_elementSurface][c_elementSurfaceY], c_mainMenuTextYHidden, 40, elasticOutAnimation)
    elseif g_chargeButton[c_elementTouch][c_elementTouchReleased] then
        -- [BRS] - The player wants to charge something. Tell them to connect a vehicle or directly start the proceedure.
        g_subState = 0
        g_wantsToCharge = true
        g_state = g_antennaSignalStrength > 0 and stateCharger or stateAwaitVehicleConnection
        setNewAnimationTarget(g_chargeButtonSurfaceX, c_mainMenuToChargingX, c_UIShiftDuration, quintInOutAnimation)
        setNewAnimationTarget(g_infoButtonSurfaceX, c_mainMenuToChargingX, c_UIShiftDuration, quintInOutAnimation)
        setNewAnimationTarget(g_dischargeButtonSurfaceX, c_mainMenuToChargingX, c_UIShiftDuration, quintInOutAnimation)
        setNewAnimationTarget(g_mainMenuTextSurfaceX, c_mainMenuToChargingX, c_UIShiftDuration, quintInOutAnimation)
    elseif g_dischargeButton[c_elementTouch][c_elementTouchReleased] then
        -- [BRS] - The player wants to discharge something. Tell them to connect a vehicle or directly start the proceedure.
        g_subState = 0
        g_wantsToCharge = false
        g_state = g_antennaSignalStrength > 0 and stateCharger  or stateAwaitVehicleConnection
        setNewAnimationTarget(g_chargeButtonSurfaceX, c_mainMenuToDischargeX, c_UIShiftDuration, quintInOutAnimation)
        setNewAnimationTarget(g_infoButtonSurfaceX, c_mainMenuToDischargeX, c_UIShiftDuration, quintInOutAnimation)
        setNewAnimationTarget(g_dischargeButtonSurfaceX, c_mainMenuToDischargeX, c_UIShiftDuration, quintInOutAnimation)
        setNewAnimationTarget(g_mainMenuTextSurfaceX, c_mainMenuToDischargeX, c_UIShiftDuration, quintInOutAnimation)
    end
end