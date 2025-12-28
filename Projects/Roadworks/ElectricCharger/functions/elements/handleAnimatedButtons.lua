require("Functions.Monitor.Touch.pressingInRectangle")
require("Functions.Animations.Framework.setNewAnimationTarget")
require("Functions.Animations.Framework.elasticOut")
require("Functions.Animations.Framework.lerpAnimation")
require("Variables.Animations.current")
require("Variables.Monitor.Elements.pressed")
require("Variables.Monitor.Elements.surface")
require("Variables.Monitor.Elements.surface.x")
require("Variables.Monitor.Elements.surface.y")
require("Variables.Monitor.Elements.surface.width")
require("Variables.Monitor.Elements.surface.height")
require("Variables.Monitor.Elements.colors")
require("Variables.Monitor.Elements.colors.alpha")

function handleAnimatedButton(element)
    surface = element[c_elementSurface]

    -- [BRS] - Handling the button's actual pressing 
    previousState = element[c_elementPressed]
    element[c_elementPressed] = PressingInRectangle(
        surface[c_elementSurfaceX][c_animationCurrent],
        surface[c_elementSurfaceY][c_animationCurrent],
        surface[c_elementSurfaceW][c_animationCurrent],
        surface[c_elementSurfaceH][c_animationCurrent]
    )

    -- [BRS] - Logic executed when the button state changes
    if previousState ~= element[c_elementPressed] then
        becamePressed = not previousState and element[c_elementPressed]
        
        -- Change alpha value of both colors of the gradient button in one go.
        for i=1, 2 do
            setNewAnimationTarget(
                element[c_elementColors][i][c_elementColorA],
                becamePressed and 255 or 128,
                becamePressed and 1 or 60,
                becamePressed and lerpAnimation or elasticOutAnimation
            )
        end
    end
end