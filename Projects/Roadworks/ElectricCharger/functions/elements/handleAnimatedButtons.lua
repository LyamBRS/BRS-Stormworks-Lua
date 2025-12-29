require("Functions.Monitor.Touch.pressingInRectangle")
require("Functions.Animations.Framework.setNewAnimationTarget")
require("Functions.Animations.Functions.elasticOut")
require("Functions.Animations.Functions.lerpAnimation")
require("Variables.Animations.current")
require("Variables.Monitor.Elements.touch")
require("Variables.Monitor.Elements.touch.pressed")
require("Variables.Monitor.Elements.touch.released")
require("Variables.Monitor.Elements.touch.pressing")
require("Variables.Monitor.Elements.surface")
require("Variables.Monitor.Elements.surface.x")
require("Variables.Monitor.Elements.surface.y")
require("Variables.Monitor.Elements.surface.width")
require("Variables.Monitor.Elements.surface.height")
require("Variables.Monitor.Elements.colors")
require("Variables.Monitor.Elements.colors.alpha")

function handleAnimatedButton(element)
    surface = element[c_elementSurface]
    touch = element[c_elementTouch]

    -- [BRS] - Handling the button's actual pressing 
    previousState = touch[c_elementTouchPressing]
    touch[c_elementTouchPressing] = PressingInRectangle(
        surface[c_elementSurfaceX][c_animationCurrent],
        surface[c_elementSurfaceY][c_animationCurrent],
        surface[c_elementSurfaceW][c_animationCurrent],
        surface[c_elementSurfaceH][c_animationCurrent]
    )

    -- [BRS] - Logic executed when the button state changes
    if previousState ~= touch[c_elementTouchPressing] then
        becamePressed = not previousState and element[c_elementTouchPressing]
        touch[c_elementTouchPressed] = becamePressed
        touch[c_elementTouchReleased] = not becamePressed
        
        -- Change alpha value of both colors of the gradient button in one go.
        for i=1, 2 do
            setNewAnimationTarget(
                element[c_elementColors][i][c_elementColorA],
                becamePressed and 255 or 128,
                becamePressed and 1 or 60,
                becamePressed and lerpAnimation or elasticOutAnimation
            )
        end
    else
        touch[c_elementTouchPressed] = false
        touch[c_elementTouchReleased] = false
    end
end