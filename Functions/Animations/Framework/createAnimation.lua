-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Create a new animation object from given parameters.
-- ### Used for
-- Creating fresh animations in scripts to instanciate
-- objects outside of tick functions for examples.
-- ### @Input
-- ##### - `start` : `number`
-- starting point of the animation. Current number
-- will equal this.
-- ##### - `target` : `number`
-- Where you want the value to end at, after `duration`
-- elapsed.
-- ##### - `duration` : `number`
-- Amount of ticks the animation should last for.
-- ##### - `animationFunction` : `function`
-- The function that will be used by the framework to update
-- the local value stored in the returned object.
-- name(start, target, ratio) format.
-- ### @Returns
-- ##### 1. `animation` : `table`
-- See animation framework index constants to know the
-- content of the object returned here.
function createAnimation(start, target, duration, animationFunction)
	return {
		start,              -- c_animationStart
		target,             -- c_animationTarget
		start,              -- c_animationCurrent
		duration,           -- c_animationDuration
		duration,           -- c_animationTimeLeft
		animationFunction   -- c_animationFunction
	}
end