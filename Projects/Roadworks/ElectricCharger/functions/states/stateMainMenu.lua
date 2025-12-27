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
    ------ Logic

    ------ State outputs

    ------ NEXT STATE HANDLING -
end