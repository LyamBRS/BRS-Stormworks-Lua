require("Functions.Animations.Functions.lerpAnimation")
-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- Rectangular gradiant going from one color to another horizontally.
-- Uses rectangleF as its function.
-- Requires lerp for gradiant management.
-- ### Used for
-- Applications that needs gradiant in only one direction.
-- Its better to use the line function if multiple angles must be
-- used.
-- ### @Input
-- ##### - `x` :     `number` = top left position of the gradiant. Inclusive.
-- ##### - `y` :     `number` = top left position of the gradiant. Inclusive.
-- ##### - `width` : `number` = width of the rectangular area in which the gradiant will be drawn. `> 0`
-- ##### - `height` : `number` = height of the rectangular area in which the gradiant will be drawn. `> 0`
-- ##### - `r1` : `number` = red hue at the top of the rectangle area
-- ##### - `g1` : `number` = green hue at the top of the rectangle area
-- ##### - `b1` : `number` = blue hue at the top of the rectangle area
-- ##### - `a1` : `number` = alpha value / opacity at the top of the rectangle area
-- ##### - `r2` : `number` = red hue at the bottom of the rectangle area
-- ##### - `g2` : `number` = green hue at the bottom of the rectangle area
-- ##### - `b2` : `number` = blue hue at the bottom of the rectangle area
-- ##### - `a2` : `number` = alpha value / opacity at the bottom of the rectangle area
-- ### @Returns
-- None
function horizontalGradiant(x, y, width, height, r1, g1, b1, a1, r2, g2, b2, a2)
    for currentY=0, height-1 do
        ratio = currentY / (height-1)
        screen.setColor(
            lerpAnimation(r1, r2, ratio),
            lerpAnimation(g1, g2, ratio),
            lerpAnimation(b1, b2, ratio),
            lerpAnimation(a1, a2, ratio)
        )
        screen.drawRectF(x, y+currentY, width, 1)
    end
end