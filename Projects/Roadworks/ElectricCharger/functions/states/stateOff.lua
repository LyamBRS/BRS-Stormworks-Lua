require("Projects.Roadworks.ElectricCharger.functions.states.stateBootingUp")
require("Projects.Roadworks.ElectricCharger.functions.stationLight.stationLightWhenInnactive")
-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- The electric charger's onTick "off" state of its state machine
-- In this state, everything is off and onTick attempts to finish
-- as soon as possible.
-- This state goes to the `bootOn` state if the player sensor
-- is detected.
-- ### Used for
-- Keeping the whole system offline and save as much server ressources
-- as humanly possible.
-- ### State's outputs
-- - Monitor            -> `false`
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
function stateOff()
    ------ Logic
    -- NONE
    ------ State outputs
    g_monitorState = false
    g_relayCable = true
    g_relayAntenna = true
    g_relayCharger = false
    g_relayDischarger = false
    stationLightWhenInnactive()

    ------ NEXT STATE HANDLING -
    if g_playerSensor then
        g_subState = 0
        g_state = stateBootingUp
    end
end