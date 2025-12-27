-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- Draw any element from its object.
-- ### Used for
-- Drawing any element, animated or not, from its given framework object.
-- ### @Input
-- ##### - `element` : `table` = Element object, created for the framework.
-- ### @Returns
-- None
function drawElement(element)
    element[3](element)
end