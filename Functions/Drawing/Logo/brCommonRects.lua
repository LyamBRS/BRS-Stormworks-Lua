-- [BRS] - [[ Information ]] --
-- `2025/12/28`
-- ### Description
-- Draws the common pixels between BRS's logo's B letter and R letter.
-- ### Used for
-- Reducing the amount of characters needed to draw the logo by 25
-- fully minified characters (where drawRectF is fully replaced) or
-- by 67 characters with Pony IDE standard minifier.
-- ### @Input
-- ##### - `x` : `number` = top left corner of the B
-- ##### - `y` : `number` = top left corner of the B
-- ##### - `scaling` : `number` = BRS' letter's pixel size... in monitor pixels
function brCommonRects(x, y, scaling)
    -- Row 1
    screen.drawRectF(x, y, 5*scaling, scaling)

    -- Row 2
    screen.drawRectF(x+4*scaling, y+scaling, scaling, scaling)

    -- Row 3
    screen.drawRectF(x, y+2*scaling, 2*scaling, scaling)
    screen.drawRectF(x+3*scaling, y+2*scaling, scaling, scaling)
end