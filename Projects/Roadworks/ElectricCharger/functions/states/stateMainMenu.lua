require("Projects.Roadworks.ElectricCharger.functions.states.stateBootingDown")
require("Projects.Roadworks.ElectricCharger.functions.stationLight.stationLightWhenInnactive")
require("Variables.Monitor.Elements.surface")
require("Variables.Monitor.Elements.surface.x")

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
        setNewAnimationTarget(g_chargeButtonSurface[c_elementSurfaceX], c_chargeButtonXShown, 80)
        setNewAnimationTarget(g_infoButtonSurface[c_elementSurfaceX], c_infoButtonXShown, 80)
        setNewAnimationTarget(g_dischargeButtonSurface[c_elementSurfaceX], c_dischargeButtonXShown, 80)
        g_subState = 1
    end

    ------ State outputs
    g_monitorState = true
    g_relayCable = true
    g_relayAntenna = true
    g_relayCharger = false
    g_relayDischarger = false
    stationLightWhenInnactive()

    ------ NEXT STATE HANDLING -
    -- [BRS] - Player left and did nothing. Boot off.
    if g_playerSensor == false then
        g_state = stateBootingDown
        g_subState = 0
        setNewAnimationTarget(g_chargeButtonSurface[c_elementSurfaceX], c_chargeButtonXHidden, 80)
        setNewAnimationTarget(g_infoButtonSurface[c_elementSurfaceX], c_infoButtonXHidden, 80)
        setNewAnimationTarget(g_dischargeButtonSurface[c_elementSurfaceX], c_dischargeButtonXHidden, 80)
    end
end