require("Functions.Animations.Framework.setNewAnimationTarget")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Creates a new background animation with a target within a specific range.
-- and a random duration within allowed range.
-- ### Used for
-- The ElectricCharger's background animations.
-- ### @Input
-- ##### - `animation`  : `table`  = Animation framework object
-- ##### - `min`        : `number` = minimum random range
-- ##### - `max`        : `number` = maximum random range
-- ### @Returns
-- None
function handleAnimationEnd(animation, min, max)
	setNewAnimationTarget(
		animation,
		math.random(min, max),
		math.random(c_minAnimationDuration, c_maxAnimationDuration)
	)
end
