require("Projects.Roadworks.ElectricCharger.functions.states.stateInfElectric")
require("Projects.Roadworks.ElectricCharger.functions.states.stateBootingDown")
require("Projects.Roadworks.ElectricCharger.functions.states.stateMainMenu")
require("Projects.Roadworks.ElectricCharger.functions.stationLight.stationLightWhenInnactive")
require("Variables.Animations.timeLeft")
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
    ------ Logic
    if g_subState == 2 then
        if brsLogoSY[c_animationTimeLeft] == 0 then
            -- [BRS] - Last letter finished. Ready for main menu
            g_subState = 3
        end
    elseif g_subState == 1 then
        -- [BRS] - Wait for the last letter to finish animating.
        if brsLogoSweep[c_animationTimeLeft] == 20 then
            -- [BRS] - Last letter finished. Set them to dissapear
            setNewAnimationTarget(brsLogoRY, 20, 50)
        end

        if brsLogoSweep[c_animationTimeLeft] == 10 then
            -- [BRS] - Last letter finished. Set them to dissapear
            setNewAnimationTarget(brsLogoSY, 20, 50)
        end

        if brsLogoSY[c_animationTimeLeft] < 15 and brsLogoSweep[c_animationTimeLeft] == 0 then
            -- [BRS] - Last letter finished. Set them to dissapear
            setNewAnimationTarget(brsLogoBY, 75, 100)
            setNewAnimationTarget(brsLogoRY, 75, 100)
            setNewAnimationTarget(brsLogoSY, 75, 100)
            setNewAnimationTarget(bootFadeAlphaBot, 0, 20)
            g_subState = 2
        end
    elseif g_subState == 0 then
        -- [BRS] - Set BRS letters to go down one by one.
        setNewAnimationTarget(brsLogoBY, 20, 50)
        setNewAnimationTarget(brsLogoSweep, 3, 30)
        setNewAnimationTarget(bootFadeAlphaTop, 0, 60)
        g_subState = 1
    end

    ------ State outputs
    g_monitorState = false
    g_relayCable = true
    g_relayAntenna = true
    g_relayCharger = false
    g_relayDischarger = false
    stationLightWhenInnactive()

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