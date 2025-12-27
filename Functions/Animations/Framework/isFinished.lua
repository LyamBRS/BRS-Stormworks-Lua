require("Variables.Animations.timeLeft")
-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- Indicates if an animation object finished animating by using its
-- `c_animationTimeLeft` internal value.
-- ### Used for
-- Saving characters. When you do more than `10` of the following:
-- - `animation[c_animationTimeLeft] == 0`
-- it becomes more character efficient to use this function everywhere.
-- ### @Input
-- ##### - `animation` : `table` = Animation object from this framework.
-- ### @Returns
-- ##### 1. `finished` : `boolean`
-- The result of `animation[c_animationTimeLeft]==0`
function isFinished(animation)
    return animation[c_animationTimeLeft]==0
end