-- [BRS] - [[ Information ]] --
-- `26/03/07`
-- ### Description
-- Draws a 1 pixel circle outline from a starting radian to an ending radian.
-- Specify the radius as well.
-- ### Used for
-- Drawing complex shapes.
-- ### @Input
-- ##### - `x` :      `float` = position of the middle of the circle
-- ##### - `y` :      `float` = position of the middle of the circle
-- ##### - `radius` : `float` = wanted radius in pixels for the circle
-- ##### - `start` :  `float` = where to start in radians
-- ##### - `ending` : `float` = where to end in radian
-- ### @Returns
-- ##### 1. `NAME` : `type`
-- Long description
-- ##### 2. `NAME` : `type` = short description
function complexCircleOutline(x, y, radius, start, ending)
    -- [BRS] - I am using this to not do too many useless for loop iterations.
    perimeter = 6.5 * radius -- 2 * pi * radius

    for radian=start, ending, math.abs((start - ending) / perimeter) do
        screen.drawRectF(
            x + radius * math.cos(radian),
            y + radius * -math.sin(radian), 
            1,
            1
        )
    end
end