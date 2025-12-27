require("Variables.Animations.framework")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Extracts each individual values from an animation object
-- ### Used for
-- Instead of reading each index of the object manually, call this and get all the variables at once.
-- Reduces the character count.
-- ### @Input
-- ##### - `animation` : `table` = Animation object, made for this framework.
-- ### @Returns
-- ##### 1. `start`    : `number`   = where the animation (current) started at
-- ##### 2. `target`   : `number`   = where the animation will end up at (current)
-- ##### 3. `current`  : `number`   = where the animation at the current time is at (between start and target) if Animate()d
-- ##### 4. `duration` : `integer`  = total amount of ticks the animation sould last for
-- ##### 5. `timeLeft` : `integer`  = amount of time the animation has left in ticks (0 = finished)
-- ##### 6. `function` : `function` = (start, target, ratio) type animation used when calling `animate()`
function extractAnimation(animation)
	return animation[c_animationStart],
			animation[c_animationTarget],
			animation[c_animationCurrent],
			animation[c_animationDuration],
			animation[c_animationTimeLeft],
			animation[c_animationFunction]
end