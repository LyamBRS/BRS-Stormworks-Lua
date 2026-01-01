require("Projects.Roadworks.ElectricCharger.functions.states.stateMainMenu")
require("Functions.Animations.Framework.setNewAnimationTarget")
-- [BRS] - [[ Information ]] --
-- `2025/12/31`
-- ### Description
-- The electric charger's infinite electric warning menu.
-- If the player leaves, boot down.
-- If the player remains and inf electric is turned off
-- go to the main menu.
-- ### Used for
-- Warning the user that infinite electric is turned on, and as such
-- the charging station is utterly useless. Come back later.
-- ### State's outputs
-- - Monitor            -> `true`
-- - Charger relay      -> `false`
-- - Discharger relay   -> `false`
-- - RGB                -> `red`
-- ### @Input
-- None
-- ### @Returns
-- None
function stateInfElectric()
    ------ Logic
    if g_subState == 0 then -- deploy the menu
        g_subState = 1
        setNewAnimationTarget(g_infElectricText[c_elementSurface][c_elementSurfaceY], c_textAreaYShown, c_UIShiftDuration)
    end

    ------ State outputs
    innactiveStation()

    ------ NEXT STATE HANDLING -
    if g_infElectric == false then
        -- [BRS] - infinite electric got turned off
        g_subState = 0
        g_state = stateMainMenu
        setNewAnimationTarget(g_infElectricText[c_elementSurface][c_elementSurfaceY], -128, c_UIShiftDuration)
    end
end