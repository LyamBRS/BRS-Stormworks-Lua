-- [BRS] - [[ Information ]] --
-- `26/03/12`
-- ### Description
-- What the function is
-- ### Used for
-- What do you use the function for
-- ### @Input
-- ##### - `size`  : `float` = how big should the grids be in pixels
-- ##### - `alpha` : `int` = 0 to 255.
-- ##### - `r1`     : `red` = 0 to 255.
-- ##### - `g1`     : `green` = 0 to 255.
-- ##### - `b1`     : `blue` = 0 to 255.
-- ##### - `r2`     : `red` = 0 to 255.
-- ##### - `g2`     : `green` = 0 to 255.
-- ##### - `b2`     : `blue` = 0 to 255.
function DEBUG_GridPosition(size, alpha, r1, g1, b1, r2, g2, b2)
    width = screen.getWidth()
    height = screen.getHeight()

    flip = true
    for x=0, width, size do
        for y=0, height, size do
            flip = not flip
            if flip then
                screen.setColor(r1, g1, b1, alpha)
            else
                screen.setColor(r2, g2, b2, alpha)
            end
            screen.drawRectF(x, y, size, size)
        end
    end
end