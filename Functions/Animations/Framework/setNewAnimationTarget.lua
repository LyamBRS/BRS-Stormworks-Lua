require("Functions.Animations.Framework.createAnimation")
require("Functions.Animations.Framework.extract")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Sets a new objective to an animation
-- ### Used for
-- handling a new target for an animation. Handles durations, currents and targets.
-- ### @Input
-- ##### - `animation` : `table`  = animation object to handle
-- ##### - `newTarget` : `number` = wanted target to reach
-- ##### - `duration`  : `number` = how long to reach that.
-- ### @Returns
-- ##### 1. `animation` : `table`
-- new animation with the proper setup we want.
function setNewAnimationTarget(animation, newTarget, duration)
	start,target,current,old,timeLeft,animationFunction = extractAnimation(animation)
	newAnimation = createAnimation(current, newTarget, duration, animationFunction)
	for i=1, 7 do
		animation[i] = newAnimation[i]
	end
end