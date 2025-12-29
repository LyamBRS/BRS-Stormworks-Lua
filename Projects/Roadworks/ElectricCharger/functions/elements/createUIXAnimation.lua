require("Functions.Animations.Functions.quintInOutAnimation")
require("Functions.Animations.Framework.createAnimation")
-- [BRS] - [[ Information ]] --
-- `2025/12/29`
-- ### Description
-- Creates a new animation for the x coordinate of an element's surface.
-- Necessary due to character saving measures, where calling createAnimation
-- on a bypass variables would dissasociate the variable from the element
-- table (pointers changing address). Hopefully this saves characters.
-- - Hardcoded to quintinout
-- - Hardcoded to UI sweep speeds
-- ### Used for
-- Saving characters
-- ### @Input
-- ##### - `element` : `table` = element from the element framework
-- ##### - `start` : `number` = where the element should start from. Sometimes its current position is ass.
-- ##### - `target` : `number` = where you want the element to end up at.
-- ### @Returns
-- None
function createUIXAnimation(element, start, target)
    element[c_elementSurface][c_elementSurfaceX] = createAnimation(
        start,
        target,
        c_UIShiftDuration,
        quintInOutAnimation
    )
end