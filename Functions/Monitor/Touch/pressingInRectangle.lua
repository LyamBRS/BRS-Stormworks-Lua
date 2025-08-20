require("Variables.Monitor.Touch.coords")
require("Variables.Monitor.Touch.pressing")
-- [BRS] - [[ Information ]] --
-- `25/08/19`
-- ### Description
-- Checks if the pressing coordinates are within a rectangle.
-- ### Used for
-- Knowing if you're pressing within a rectangle coordinates.
-- ### @Input
-- ##### - `x` : `number` = The x coordinate. Just like drawRectF
-- ##### - `y` : `number` = The y coordinate. Just like drawRectF
-- ##### - `w` : `number` = The width of the rectangle. Just like drawRectF
-- ##### - `h` : `number` = The height of the rectangle. Just like drawRectF
-- ### @Returns
-- ##### 1. `pressingInRectangle` : `boolean`
-- `true` if you're pressing inside the specified coordinates. `false` otherwise.
function PressingInRectangle(x, y, w, h)
    return (g_pressingCoordsX >= x and g_pressingCoordsY >= y and g_pressingCoordsX <= x+w and g_pressingCoordsY <= y+h) and g_pressing
end