require("Functions.Maths.clamp")
-- [BRS] - [[ Information ]] --
-- `26/03/13`
-- ### Description
-- Slightly modified color correction function from u/thattiguy.
-- It's better than the standard color correction algorithm but this
-- one had values slightly tweaked (with no difference too noticeable)
-- to shave off some characters off the numbers.
-- ### Used for
-- Live color corrections. Ideally, applications correct colors before
-- putting them in their scripts. However, sometimes you need it from
-- property values and cannot trust the end user.
-- ### @Input
-- ##### - `input` : `float` = 0-255. caps at 250.
-- ### @Returns
-- Nothing
function correctColor(color)
    return Clamp((((251 - math.min(color,251)) / 478830) ^ -.576) - 79, 0, 255)
end