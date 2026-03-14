require("Functions.Animations.Framework.createQuadAnimationTable")
require("Functions.Base64.Images.drawAnimatedUnicoloredImage")
require("Functions.Base64.Images.decodeUnicolorImage")
-- [BRS] - [[ Information ]] --
-- `2026/03/14`
-- ### Description
-- Creates a new basic BRIO base64 object that has colors within.
-- This one contains the property value fetching.
-- ### Used for
-- Animating all the base64 images used within a script.
-- ### @Input
-- ##### - `x` :     `number` = top left position of the gradiant. Inclusive.
-- ##### - `y` :     `number` = top left position of the gradiant. Inclusive.
-- ##### - `scale` : `number` = scale to multiply the rectangles with
-- ##### - `height` : `number` = height of the rectangular area in which the gradiant will be drawn. `> 0`
-- ##### - `propertyName`: `string` = name of the property that contains the encoded object
-- ### @Returns
-- ##### 1. `button` : `table` = object from the button framework
function newAnimatedBase64UnicolorImage(x, y, scale, r, g, b, a, propertyName, animationFunction)
    return {
        createQuadAnimationTable(x, y, scale, 0, animationFunction),   -- Surface area
        {                                                                   -- Color area
            createQuadAnimationTable(r, g, b, a, animationFunction)
        },
        drawAnimatedUnicoloredImage,                                        -- element drawing function
        {},                                                                 -- Touch data
        {
            decodeUnicolorImage(property.getText(propertyName))
        }
    }
end