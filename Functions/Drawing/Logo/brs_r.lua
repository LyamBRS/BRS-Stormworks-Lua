require("Functions.Drawing.Logo.brCommonRects")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Draws BRS's R letter with scaling. No BRIO drawing.
-- ### Used for
-- basic scripts that don't need full scalable alphabet
-- and have no BRIO implementation for drawings.
-- ### @Input
-- ##### - `x` : `number` = top left corner of the R
-- ##### - `y` : `number` = top left corner of the R
-- ##### - `scaling` : `number` = BRS' letter's pixel size... in monitor pixels
function logoR(x, y, scaling)
    brCommonRects(x, y, scaling)

    -- Downward leg of the R
    screen.drawRectF(x+4*scaling, y+3*scaling, scaling, scaling*2)

    -- Row 5
    screen.drawRectF(x, y+4*scaling, 2*scaling, scaling)
end