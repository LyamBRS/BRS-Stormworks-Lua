require("Functions.Animations.Framework.createAnimation")
require("Functions.Monitor.Buttons.Animated.drawAnimatedRectangleGradientButton")
-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- Creates a new button object, for the button management framework.
-- The created button will have required data for a rectangular button.
-- Call this in your code, especially BeforeScript management.
-- ### Used for
-- Creating complex animated buttons with a simple function.
-- Saves characters when creating a lot of buttons.
-- Don't use this function if creating only a couple buttons.
-- ### @Input
-- ##### - `x` :     `number` = top left position of the gradiant. Inclusive.
-- ##### - `y` :     `number` = top left position of the gradiant. Inclusive.
-- ##### - `width` : `number` = width of the rectangular area in which the gradiant will be drawn. `> 0`
-- ##### - `height` : `number` = height of the rectangular area in which the gradiant will be drawn. `> 0`
-- ### @Returns
-- ##### 1. `button` : `table` = object from the button framework
function newAnimatedRectangleGradiantButton(x, y, width, height, r1, g1, b1, a1, r2, g2, b2, a2, animationFunction)
    return {
        createQuadAnimationTable(x, y, width, height, animationFunction),   -- Surface area
        {                                                                   -- Color area
            createQuadAnimationTable(r1, g1, b1, a1, animationFunction),        -- gradient start
            createQuadAnimationTable(r2, g2, b2, a2, animationFunction),        -- gradient end
        },
        drawAnimatedRectangleGradientButton,                                -- element drawing function
        {                                                                   -- Touch data
            false,
            false,
            false,
        }
    }
end

function createQuadAnimationTable(a,b,c,d, animationFunction)
    return {
        createAnimation(a, a, 0, animationFunction),
        createAnimation(b, b, 0, animationFunction),
        createAnimation(c, c, 0, animationFunction),
        createAnimation(d, d, 0, animationFunction),
    }
end