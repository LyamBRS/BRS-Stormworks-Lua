-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Standard Lerp.
-- ### Used for
-- Various animation purposes, through the animation framework.
-- Can also be used like a regular lerp without the animation framework if you loopback the feedback.
-- ### @Input
-- ##### - `start`  : `number` = Where the animation starts from, when the ratio equals 0
-- ##### - `target` : `number` = Where the animation ends up, when the ratio equals 1
-- ### @Returns
-- ##### 1. `result` : `number` = value between `start` and `target` after the animation is applied at `ratio`
function lerpAnimation(start, target, ratio)
	return start * (1-ratio) + target * ratio
end