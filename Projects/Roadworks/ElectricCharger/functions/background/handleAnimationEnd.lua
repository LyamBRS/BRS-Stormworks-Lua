require("Projects.Roadworks.ElectricCharger.functions.background.newBackgroundAnimation")
require("Variables.Animations.current")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Creates a new background animation with a target within a specific range.
-- ### Used for
-- The ElectricCharger's background animations.
-- ### @Input
-- ##### - `animation`  : `table`  = Animation framework object
-- ##### - `min`        : `number` = minimum random range
-- ##### - `max`        : `number` = maximum random range
-- ### @Returns
-- ##### 1. `animation` : `table`
-- New background animation with a random duration between min and max.
function handleAnimationEnd(animation, min, max)
	return newBackgroundAnimation(
		animation[c_animationCurrent],	-- Start from the current location
		math.random(min, max)			-- Go to a new location
	)
end
