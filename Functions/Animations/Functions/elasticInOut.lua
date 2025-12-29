require("Functions.Animations.Functions.lerpAnimation")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Standard web "elastic out" animation.
-- ### Used for
-- Various animation purposes, through the animation framework.
-- ### @Input
-- ##### - `start`  : `number` = Where the animation starts from, when the ratio equals 0
-- ##### - `target` : `number` = Where the animation ends up, when the ratio equals 1
-- ### @Returns
-- ##### 1. `result` : `number` = value between `start` and `target` after the animation is applied at `ratio`
function elasticOutAnimation(start, target, ratio)
	c = (2*3.14)/4.5
	if ratio < .5 then
		e = -(2^(20*ratio-10)) * math.sin((ratio*20-11.125)*c)/2
	else
		e = ((2^(-20*ratio+10)) * math.sin((ratio*20-11.125)*c) /2) + 1
	end
	return lerpAnimation(start, target, e)
end