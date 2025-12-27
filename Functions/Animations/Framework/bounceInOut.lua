require("Functions.Animations.Framework.bounceOut")
require("Functions.Animations.Framework.bounceIn")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Standard web "bounce in out" animation.
-- ### Used for
-- Various animation purposes, through the animation framework.
-- ### @Input
-- ##### - `start`  : `number` = Where the animation starts from, when the ratio equals 0
-- ##### - `target` : `number` = Where the animation ends up, when the ratio equals 1
-- ### @Returns
-- ##### 1. `result` : `number` = value between `start` and `target` after the animation is applied at `ratio`
function bounceInOutAnimation(start, target, ratio)
	target = target - start
	if ratio < .5 then
		return bounceInAnimation(0, target, ratio*2)*.5 + start
	else
		return bounceOutAnimation(0, target, ratio*2-1)*.5 + target * .5 + start
	end
end