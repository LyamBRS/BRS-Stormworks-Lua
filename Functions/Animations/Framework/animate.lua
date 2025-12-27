require("Variables.Animations.framework")
require("Functions.Animations.Framework.extract")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Brings forwards in time an animation object.
-- ### Used for
-- Reducing the time left
-- Changing the current value through the target, start and times.
-- Using the animation function.
-- ### @Input
-- ##### - `animation` : `table`
-- See the Animation framework objects and constant indexes.
-- ### @Returns
-- ##### 1. `animation` : `table`
-- updated input animation table.
function animate(animation)
    -- [BRS] - Ensures current value matches the target
    -- Prevent complex animation function from executing when it doesn't need to.
	if animation[c_animationTimeLeft] == 0 then
		animation[c_animationCurrent] = animation[c_animationTarget]
		return animation
	end
    
	start,target,outcome,duration,timeLeft,animationFunction = extractAnimation(animation)
	timeLeft=timeLeft-1
	ratio = 1-(timeLeft/duration)
	outcome = animationFunction(start,target,ratio)
	
	animation[c_animationCurrent] = outcome
	animation[c_animationTimeLeft] = timeLeft
	return animation
end