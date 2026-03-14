require("Functions.Animations.Framework.createAnimation")
-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- Returns a table, containing 4 new animations with the target already at the current value
-- all having the same animation function.
-- ### Used for
-- Creating color animations, rectangle animations... anything where there's 4 values.
-- ### @Input
-- ##### - `a` : `float` = start value of animation at index 1
-- ##### - `b` : `float` = start value of animation at index 2
-- ##### - `c` : `float` = start value of animation at index 3
-- ##### - `d` : `float` = start value of animation at index 4
-- ### @Returns
-- ##### 1. `result` : `Table`
-- 4 animation objects from `createAnimation`
function createQuadAnimationTable(a,b,c,d, animationFunction)
    return {
        createAnimation(a, a, 0, animationFunction),
        createAnimation(b, b, 0, animationFunction),
        createAnimation(c, c, 0, animationFunction),
        createAnimation(d, d, 0, animationFunction),
    }
end