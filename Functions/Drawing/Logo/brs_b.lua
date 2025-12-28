require("Functions.Drawing.Logo.brCommonRects")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Draws BRS's B letter with scaling. No BRIO drawing.
-- ### Used for
-- basic scripts that don't need full scalable alphabet
-- and have no BRIO implementation for drawings.
-- ### @Input
-- ##### - `x` : `number` = top left corner of the B
-- ##### - `y` : `number` = top left corner of the B
-- ##### - `scaling` : `number` = BRS' letter's pixel size... in monitor pixels
function logoB(x, y, scaling)
    brCommonRects(x, y, scaling)

    -- Row 4
    screen.drawRectF(x+4*scaling, y+3*scaling, scaling, scaling)

    -- Row 5
    screen.drawRectF(x, y+4*scaling, 5*scaling, scaling)
end