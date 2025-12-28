require("Projects.Roadworks.ElectricCharger.functions.background.handleAnimationEnd")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Creates a new animation for a segment of a bezier curve.
-- ### Used for
-- Giving a new bezier point a new goal.
-- ### @Input
-- ##### - `segment`   : `table`   = segment object
-- ##### - `animIndex` : `integer` = which animation of the segment object to animate
-- ##### - `min`        : `number` = minimum random range
-- ##### - `max`        : `number` = maximum random range
function newSegmentGoal(segment, animIndex, min, max)
	handleAnimationEnd(
		segment[animIndex],
		min,
		max
	)
end