-- [BRS] - [[ Information ]] --
-- `2025/12/27`
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
-- - Cable relay        -> `true`
-- - Antenna relay      -> `true`
-- - Charger relay      -> `false`
-- - Discharger relay   -> `false`
-- - RGB                -> `red`
-- ### @Input
-- None
-- ### @Returns
-- None
function stateInfElectric()
    ------ Logic

    ------ State outputs

    ------ NEXT STATE HANDLING -
end