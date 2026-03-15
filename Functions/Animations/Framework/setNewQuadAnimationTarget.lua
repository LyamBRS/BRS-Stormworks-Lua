require("Functions.Animations.Framework.setNewAnimationTarget")
-- [BRS] - [[ Information ]] --
-- `2026/03/15`
-- ### Description
-- Just like a setNewAnimationTarget, but with an array of 4 animations.
-- ### Used for
-- Managing colors or rectangles that have animations for all their parts
-- and they need to be changed all at once. If you only need 1, it can get
-- annoying.
-- ### @Input
-- ##### - `animation` : `Table` = Created from `createQuadAnimationTable`
-- ##### - `a` : `float` = new target for the animation at index 1
-- ##### - `b` : `float` = new target for the animation at index 2
-- ##### - `c` : `float` = new target for the animation at index 3
-- ##### - `d` : `float` = new target for the animation at index 4
-- ##### - `duration`  : `int` = how many animation updates it should take to reach the target
-- ### @Returns
-- Nothing
-- 4 animation objects from `createAnimation`
function setNewQuadAnimationTarget(animation, a,b,c,d, duration, animationFunction)
    return {
        setNewAnimationTarget(animation[1], a, duration, animationFunction),
        setNewAnimationTarget(animation[2], b, duration, animationFunction),
        setNewAnimationTarget(animation[3], c, duration, animationFunction),
        setNewAnimationTarget(animation[4], d, duration, animationFunction),
    }
end