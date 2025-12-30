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
-- Function to include with rounded animated gradient button
-- to allow them to utilize standard gradient functions for
-- their drawing.
-- ### Used for
-- allowing elements to carry their own drawing functions.
-- ### @Input
-- ##### - `element` : `table` = gradiant button
-- ### @Returns
-- None
function drawAnimatedRectangleGradientButton(element)
    coords = element[c_elementSurface]
    colorA = element[c_elementColors][1]
    colorB = element[c_elementColors][2]

    x = coords[c_elementSurfaceX][c_animationCurrent]
    y = coords[c_elementSurfaceY][c_animationCurrent]
    w = coords[c_elementSurfaceW][c_animationCurrent]
    h = coords[c_elementSurfaceH][c_animationCurrent]

    if x > 96 or y > 64 or x<-w or y<-h then
        return
    end
    
    rounded45DegreeGradient(
        x,
        y,
        w,
        h,
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