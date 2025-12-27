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
        {                                                           -- Element area
            createAnimation(x, x, 0, animationFunction),                -- X -> c_xIndex
            createAnimation(y, y, 0, animationFunction),                -- Y -> c_yIndex
            createAnimation(width, width, 0, animationFunction),        -- width
            createAnimation(height, height, 0, animationFunction)       -- height
        },
        {                                                           -- Color area
            {                                                           -- element color / gradiant 1
                createAnimation(r1, r1, 0, animationFunction),
                createAnimation(g1, g1, 0, animationFunction),
                createAnimation(b1, b1, 0, animationFunction),
                createAnimation(a1, a1, 0, animationFunction),
            },
            {                                                           -- gradiant 2
                createAnimation(r2, r2, 0, animationFunction),
                createAnimation(g2, g2, 0, animationFunction),
                createAnimation(b2, b2, 0, animationFunction),
                createAnimation(a2, a2, 0, animationFunction),
            }
        },
        drawAnimatedRectangleGradientButton,                            -- element drawing function
        false,                                                          -- element currently pressed
    }
end