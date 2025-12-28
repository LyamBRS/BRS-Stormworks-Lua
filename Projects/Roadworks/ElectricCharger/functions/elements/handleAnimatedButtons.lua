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

    -- [BRS] - Management on immediate press of the button
    if not previousState and element[c_elementPressed] then
        setNewAnimationTarget(
            element[c_elementColors][1][c_elementColorA],
            255,
            1,
            lerpAnimation
        )
        setNewAnimationTarget(
            element[c_elementColors][2][c_elementColorA],
            255,
            1,
            lerpAnimation
        )
    end

    -- [BRS] - Management on immediate release of the button
    if previousState and not element[c_elementPressed] then
        setNewAnimationTarget(
            element[c_elementColors][1][c_elementColorA],
            128,
            60,
            elasticOutAnimation
        )
        setNewAnimationTarget(
            element[c_elementColors][2][c_elementColorA],
            128,
            60,
            elasticOutAnimation
        )
    end
end