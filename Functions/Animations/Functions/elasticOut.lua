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
    c = (2*3.14)/3
	e = ((2)^(-10*ratio)) * math.sin((ratio*10-.75)*c) + 1
	return lerpAnimation(start, target, e)
end