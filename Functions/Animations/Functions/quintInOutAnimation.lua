require("Functions.Animations.Functions.lerpAnimation")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Standard web "quint in out" animation.
-- ### Used for
-- Various animation purposes, through the animation framework.
-- ### @Input
-- ##### - `start`  : `number` = Where the animation starts from, when the ratio equals 0
-- ##### - `target` : `number` = Where the animation ends up, when the ratio equals 1
-- ### @Returns
-- ##### 1. `result` : `number` = value between `start` and `target` after the animation is applied at `ratio`
function quintInOutAnimation(start, target, ratio)
	if ratio < .5 then
		e = 16*ratio*ratio*ratio*ratio*ratio
	else
		e = 1-((-2*ratio+2)^5)/2
	end
	return lerpAnimation(start,target,e)
end