-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Draws BRS's S letter with scaling. No BRIO drawing.
-- ### Used for
-- basic scripts that don't need full scalable alphabet
-- and have no BRIO implementation for drawings.
-- ### @Input
-- ##### - `x` : `number` = top left corner of the S
-- ##### - `y` : `number` = top left corner of the S
-- ##### - `scaling` : `number` = BRS' letter's pixel size... in monitor pixels
function logoS(x, y, scaling)
    -- Row 1
    screen.drawRectF(x+scaling, y, 4*scaling, scaling)

    -- Row 2
    screen.drawRectF(x, y+scaling, scaling, scaling)

    -- Row 3
    screen.drawRectF(x, y+2*scaling, 5*scaling, scaling)

    -- Row 4
    screen.drawRectF(x+4*scaling, y+3*scaling, scaling, scaling)

    -- Row 5
    screen.drawRectF(x, y+4*scaling, 4*scaling, scaling)
end