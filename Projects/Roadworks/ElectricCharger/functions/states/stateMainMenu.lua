require("Projects.Roadworks.ElectricCharger.functions.states.stateBootingDown")
require("Projects.Roadworks.ElectricCharger.functions.states.stateAwaitVehicleConnection")
require("Projects.Roadworks.ElectricCharger.functions.states.stateCharger")
require("Projects.Roadworks.ElectricCharger.functions.outputManagement.innactiveStation")
require("Functions.Animations.Functions.elasticOut")
require("Functions.Animations.Functions.quintInOutAnimation")
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

    chargedPressed = g_chargeButton[c_elementTouch][c_elementTouchReleased]
    dischargePressed = g_dischargeButton[c_elementTouch][c_elementTouchReleased]

    ------ State outputs
    innactiveStation()

    ------ NEXT STATE HANDLING -
    -- [BRS] - Player left and did nothing. Boot off.
    g_state = g_playerSensor and g_state or stateBootingDown
    -- [BRS] - Player pressed a charge button. If something is connected, directly go to it.
    g_state = (chargedPressed or dischargePressed) and (
        g_antennaSignalStrength > 0 and stateCharger or stateAwaitVehicleConnection
    ) or g_state
    -- [BRS] - inf electric got turned on, fuck right off to the menu
    g_state = g_infElectric and stateInfElectric or g_state

    if g_state ~= stateMainMenu then
        g_subState = 0
        -- [BRS] - If we want to charge, slide the UI this way, otherwise the other way.
        direction = chargedPressed and c_mainMenuToChargingX or c_mainMenuToDischargeX
        g_wantsToCharge = chargedPressed

        -- [BRS] - UI animations are different if you boot off
        if g_playerSensor then -- standard ui shift animations
            setNewAnimationTarget(g_chargeButtonSurfaceX, direction, c_UIShiftDuration, quintInOutAnimation)
            setNewAnimationTarget(g_infoButtonSurfaceX, direction, c_UIShiftDuration, quintInOutAnimation)
            setNewAnimationTarget(g_dischargeButtonSurfaceX, direction, c_UIShiftDuration, quintInOutAnimation)
            setNewAnimationTarget(g_mainMenuTextSurfaceX, direction, c_UIShiftDuration, quintInOutAnimation)
        else -- boot off animations
            setNewAnimationTarget(g_chargeButtonSurfaceX, c_chargeButtonXHidden, c_UIShiftDuration, elasticOutAnimation)
            setNewAnimationTarget(g_infoButtonSurfaceX, c_infoButtonXHidden, c_UIShiftDuration, elasticOutAnimation)
            setNewAnimationTarget(g_dischargeButtonSurfaceX, c_dischargeButtonXHidden, c_UIShiftDuration, elasticOutAnimation)
            setNewAnimationTarget(g_mainMenuText[c_elementSurface][c_elementSurfaceY], c_mainMenuTextYHidden, c_UIShiftDuration, elasticOutAnimation)
        end
    end
end