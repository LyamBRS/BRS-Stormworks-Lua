require("Functions.Animations.Framework.quintInOutAnimation")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Creates a new animation with a set animation function and a random duration
-- ### Used for
-- The electric charger's background animations.
-- ### @Input
-- ##### - `start`  : `number` = where the animation starts at
-- ##### - `target` : `number` = Where the animation should end at
-- ### @Returns
-- ##### 1. `animation` : `table`
-- From the animation framework.
function newBackgroundAnimation(start, target)
	duration = math.random(c_minAnimationDuration, c_maxAnimationDuration)
	return {
		start,
		target,
		start,
		duration,
		duration,
		quintInOutAnimation
	}
end