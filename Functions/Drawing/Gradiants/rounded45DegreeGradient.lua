require("Functions.Animations.Functions.lerpAnimation")
-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- Rectangular gradiant going from one color to another diagonally.
-- at a 45 degree angle -> `//////`
-- Uses rectangleF as its function.
-- Requires lerp for gradiant management.
-- The 4 corner pixels are **cut off** in this function
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
function rounded45DegreeGradient(x, y, w, h, r1, g1, b1, a1, r2, g2, b2, a2)

    x=math.floor(x)
    y=math.floor(y)
    w=math.floor(w)
    h=math.floor(h)

    h = h-1
    w = w-1
    max = w + h

    for currentX=0, max do
        ratio = currentX/max
        screen.setColor(
            lerpAnimation(r1, r2, ratio),
            lerpAnimation(g1, g2, ratio),
            lerpAnimation(b1, b2, ratio),
            lerpAnimation(a1, a2, ratio)
        )

        diagonalX = currentX>w and x+w or currentX + x
        diagonalY = currentX>w and y + currentX-w or y

        while diagonalX>=x and diagonalY<=y+h do
            if not (
                (diagonalX==x and diagonalY==y) or
                (diagonalX==x and diagonalY==y+h) or
                (diagonalX==x+w and diagonalY==y) or 
                (diagonalX==x+w and diagonalY==y+h)
            ) then
                screen.drawRectF(diagonalX, diagonalY, 1, 1)
            end
            diagonalX = diagonalX - 1
            diagonalY = diagonalY + 1
        end
    end
end
