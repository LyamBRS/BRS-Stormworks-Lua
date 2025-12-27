require("Functions.Drawing.Gradiants.rounded45DegreeGradient")
require("Variables.Animations.current")
-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- Parses the element object and draws it with its included function
-- ### Used for
-- allowing elements to carry their own drawing functions.
-- ### @Input
-- ##### - `element` : `table` = gradiant button
-- ##### - `y` :     `number` = top left position of the gradiant. Inclusive.
-- ##### - `width` : `number` = width of the rectangular area in which the gradiant will be drawn. `> 0`
-- ##### - `height` : `number` = height of the rectangular area in which the gradiant will be drawn. `> 0`
-- ### @Returns
-- ##### 1. `button` : `table` = object from the button framework
function drawAnimatedRectangleGradientButton(element)
    coords = element[1]
    colorA = element[2][1]
    colorB = element[2][2]
    
    rounded45DegreeGradient(
        coords[1][c_animationCurrent],
        coords[2][c_animationCurrent],
        coords[3][c_animationCurrent],
        coords[4][c_animationCurrent],
        colorA[1][c_animationCurrent],
        colorA[2][c_animationCurrent],
        colorA[3][c_animationCurrent],
        colorA[4][c_animationCurrent],
        colorB[1][c_animationCurrent],
        colorB[2][c_animationCurrent],
        colorB[3][c_animationCurrent],
        colorB[4][c_animationCurrent]
    )
end