require("Functions.Animations.Framework.bounceOut")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Standard web "bounce in" animation.
-- ### Used for
-- Various animation purposes, through the animation framework.
-- ### @Input
-- ##### - `start`  : `number` = Where the animation starts from, when the ratio equals 0
-- ##### - `target` : `number` = Where the animation ends up, when the ratio equals 1
-- ### @Returns
-- ##### 1. `result` : `number` = value between `start` and `target` after the animation is applied at `ratio`
function bounceInAnimation(start, target, ratio)
	return target-bounceOutAnimation(0,target,1-ratio)+start
end