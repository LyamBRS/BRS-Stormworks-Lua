require("Variables.Monitor.Elements.surface.x")
require("Variables.Monitor.Elements.surface.y")
require("Variables.Monitor.Elements.surface.width")
require("Variables.Monitor.Elements.surface.height")
require("Variables.Animations.current")
-- [BRS] - [[ Information ]] --
-- `2025/12/28`
-- ### Description
-- Draws centered text within a generic text box, at the
-- coordinates given by an animated surface.
-- ### Used for
-- Doing half-assed text buttons without needing a full
-- framework of parents and childs.
-- ### @Input
-- ##### - `surface` : `table` = {x,y,w,h} from the element framework.
-- ##### - `text` : `string` = to display on the surface
-- ### @Returns
-- None
function drawTextOnSurface(surface, text)
    screen.drawTextBox(
        surface[c_elementSurfaceX][c_animationCurrent],
        surface[c_elementSurfaceY][c_animationCurrent],
        surface[c_elementSurfaceW][c_animationCurrent],
        surface[c_elementSurfaceH][c_animationCurrent],
        text,
        0,
        0
    )
end