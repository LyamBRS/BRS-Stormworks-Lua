require("Functions.Drawing.Gradiants.rounded45DegreeGradient")
require("Variables.Animations.current")
require("Variables.Monitor.Elements.colors")
require("Variables.Monitor.Elements.surface")
require("Variables.Monitor.Elements.surface.x")
require("Variables.Monitor.Elements.surface.y")
require("Variables.Monitor.Elements.surface.width")
require("Variables.Monitor.Elements.surface.height")
require("Variables.Monitor.Elements.colors.red")
require("Variables.Monitor.Elements.colors.green")
require("Variables.Monitor.Elements.colors.blue")
require("Variables.Monitor.Elements.colors.alpha")
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
    coords = element[c_elementSurface]
    colorA = element[c_elementColors][1]
    colorB = element[c_elementColors][2]
    
    rounded45DegreeGradient(
        coords[c_elementSurfaceX][c_animationCurrent],
        coords[c_elementSurfaceY][c_animationCurrent],
        coords[c_elementSurfaceW][c_animationCurrent],
        coords[c_elementSurfaceH][c_animationCurrent],
        colorA[c_elementColorR][c_animationCurrent],
        colorA[c_elementColorG][c_animationCurrent],
        colorA[c_elementColorB][c_animationCurrent],
        colorA[c_elementColorA][c_animationCurrent],
        colorB[c_elementColorR][c_animationCurrent],
        colorB[c_elementColorG][c_animationCurrent],
        colorB[c_elementColorB][c_animationCurrent],
        colorB[c_elementColorA][c_animationCurrent]
    )
end