require("Projects.Roadworks.ElectricCharger.functions.states.bootingStateLogic")
require("Projects.Roadworks.ElectricCharger.functions.states.stateBootingUp")
require("Projects.Roadworks.ElectricCharger.functions.states.stateOff")
-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- The electric charger's boot down animation sequence's state.
-- ### Used for
-- Creating a seemless animation between the monitor's on state
-- and a black monitor
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
function stateBootingDown()
    -- print("state: booting down")
    ------ Logic
    bootingStateLogic(false)

    ------ State outputs
    -- Inside of booting state logic

    ------ NEXT STATE HANDLING -
    if g_subState == 3 then
        g_subState = 0
        g_state = g_playerSensor and stateBootingUp or stateOff
    end
end