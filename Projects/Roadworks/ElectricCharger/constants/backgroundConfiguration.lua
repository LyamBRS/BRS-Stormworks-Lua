-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Defines how many different bezier curves to have in the charger's
-- background
c_bezierCurveCount = 7

-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- How many subsections, each segments of the curve should be made out of.
-- The less, the more angular the bezier curve will be, between each segments.
c_bezierSegmentSubsections = 10

-- [BRS] - [[ Information ]] --
-- `2025/12/28`
-- ### Description
-- Defines the amount of points each bezier curves should have
c_pointsPerCurve = 6

-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Bezier curves get thicker at the middle and thinner on their edges.
-- this is the random range the thickness can have, in pixels.
c_minSizing = 30
c_maxSizing = 60

-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Random range in ticks, within which background animations last.
c_minAnimationDuration = 560
c_maxAnimationDuration = 960

-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Size within which the bezier curve's points can generate in for the
-- animation. Needs to be larger than the monitor size otherwise edges won't
-- have enough coverage.
c_minX = -64
c_maxX = 160 	-- 96+64
c_minY = -64
c_maxY = 128	-- 64+64

-- [BRS] - Allow bezier drawing for loop to pick the right ranges without needing 2 functions
g_bezierPointCoordinateRanges = {
	{c_minX, c_maxX},
	{c_minY, c_maxY}
}

-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Random colors the bezier curves can have. Each change from color A to B
-- within min and max.
c_minRed = 50
c_maxRed = 255
c_minGreen = 0
c_maxGreen = 50
c_minBlue = 150
c_maxBlue = 255
c_minAlpha = 5
c_maxAlpha = 40

-- [BRS] - Exists to allow for loop to handle all color animations at once.
colorRanges = {
	{c_minRed, c_maxRed},
	{c_minGreen, c_maxGreen},
	{c_minBlue, c_maxBlue},
	{c_minAlpha, c_maxAlpha}
}