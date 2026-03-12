require("Functions.Maths.clamp")

-- [BRS] - [[ Information ]] --
-- `26/03/07`
-- ### Description
-- Slightly modified color correction function from u/thattiguy.
-- It's better than the standard color correction algorithm but this
-- one had values slightly tweaked (with no difference too noticeable)
-- to shave off some characters off the numbers.
-- ### Used for
-- Live color correction. Ideally, applications correct colors before
-- putting them in their scripts. However, sometimes you need it from
-- property values and cannot trust the end user.
-- ### @Input
-- ##### - `red` : `float` = 0-255. caps at 250.
-- ##### - `green` : `float` = 0-255. caps at 250.
-- ##### - `blue` : `float` = 0-255. caps at 250.
-- ##### - `alpha` : `float` = 0-255. Not corrected. Optional.
-- ### @Returns
-- Nothing
function setCorrectedColor(red, green, blue, alpha)
    alpha = alpha==nil and 255 or alpha
    screen.setColor(
        _correctColor(red),
        _correctColor(green),
        _correctColor(blue),
        alpha
    )
end

function _correctColor(color)
    return Clamp((((251 - math.min(color,251)) / 478830) ^ -.576) - 79, 0, 255)
end