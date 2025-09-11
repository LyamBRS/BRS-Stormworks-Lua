-- [BRS] - [[ Information ]] --
-- `25/09/10`
-- ### Description
-- Implementation of math.clamp.
-- **WARNING:** You use *more* characters using this function than using its implementation directly. You have to be using a LOT of clamping to justify this.
-- ### Used for
-- Ensuring a value doesn't reach higher or lower than set values.
-- ### @Input
-- ##### - `input` : `float` = The number to clamp
-- ##### - `min` : `float` = minimum value reached.
-- ##### - `max` : `float` = maximum value reached.
-- ### @Returns
-- ##### 1. `clamped` : `float` = clamped value between low and high.
function Clamp(input, min, max)
    return math.max(
        math.min(input, max),
        min
    )
end