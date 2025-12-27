require("Projects.Roadworks.ElectricCharger.functions.states.stateInfElectric")
require("Projects.Roadworks.ElectricCharger.functions.states.stateBootingDown")
require("Projects.Roadworks.ElectricCharger.functions.states.stateMainMenu")
require("Projects.Roadworks.ElectricCharger.functions.states.bootingStateLogic")
require("Projects.Roadworks.ElectricCharger.functions.stationLight.stationLightWhenInnactive")
-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- The electric charger's boot up animation sequence's state.
-- ### Used for
-- Creating a seemless animation between the monitor's off state
-- and a pre-main menu experience.
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
function stateBootingUp()
    print("state: booting up")
    ------ Logic
    bootingStateLogic(true)

    ------ State outputs
    -- Inside of bootingStateLogic

    ------ NEXT STATE HANDLING -
    if g_subState == 3 then
        g_subState = 0
        if g_playerSensor then
            -- [BRS] - The player is still there... but inf electric is turned on.
            -- [BRS] - The player is still there, allow them to interact with the main menu
            g_state = g_infElectric and stateInfElectric or stateMainMenu
        else
            -- [BRS] - The player left. Start the booting down proceedure.
            g_state = stateBootingDown
        end
    end
end