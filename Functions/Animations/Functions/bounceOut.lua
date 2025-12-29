-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Standard web "bounce Out" animation.
-- ### Used for
-- Various animation purposes, through the animation framework.
-- ### @Input
-- ##### - `start`  : `number` = Where the animation starts from, when the ratio equals 0
-- ##### - `target` : `number` = Where the animation ends up, when the ratio equals 1
-- ### @Returns
-- ##### 1. `result` : `number` = value between `start` and `target` after the animation is applied at `ratio`
function bounceOutAnimation(start, target, ratio)
	ratio = ratio / 1
	target = target - start
	if ratio < (1 / 2.75) then
	    return target * (7.5625 * ratio * ratio) + start
	elseif ratio < (2 / 2.75) then
	    ratio = ratio - 1.5 / 2.75
	    return target * (7.5625 * (ratio) * ratio + .75) + start
	elseif ratio < (2.5 / 2.75) then
	    ratio = ratio - 2.25 / 2.75
	    return target * (7.5625 * ratio * ratio + .9375) + start
	else
	    ratio = ratio - 2.625 / 2.75
	    return target * (7.5625 * ratio * ratio + .984375) + start
	end
end