require("Variables.Monitor.Elements.surface")
require("Variables.Monitor.Elements.colors")
require("Functions.Animations.Framework.animate")
-- [BRS] - [[ Information ]] --
-- `2025/12/29`
-- ### Description
-- Automatically parses animated UI elements (made by the framework)
-- and animates all their variables that can be animated.
-- ### Used for
-- Preventing the need of copy pasting animate functions for all the
-- attributes of elements. Best used in a for loop with all ur other
-- elements. Only use this in cases where it actually saves you characters.
-- ### @Input
-- ##### - `element` : `table` = From the element framework.
-- ### @Returns
-- None
function animateElement(element)
    surface = element[c_elementSurface]
    colors = element[c_elementColors]

    for i=1, #surface do
        animate(surface[i])
    end

    for i=1, #colors do
        for color=1, #colors[i] do
            animate(colors[i][color])
        end
    end
end