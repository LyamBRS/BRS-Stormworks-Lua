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
-- nothing
function complexCircleOutline(x, y, radius, start, ending)
	arc = math.abs(ending - start)
    length = arc * radius

    segments = math.max(1, math.floor(length)) -- ~1 pixel per step
    step = arc / (segments)

    for i = 0, segments do
        radian = start + i * step
        screen.drawRectF(
            x + radius * math.cos(radian),
            y - radius * math.sin(radian),
            1,
            1
        )
    end
end