require("Projects.Roadworks.ElectricCharger.functions.background.createBackgroundAnimation")

-- [BRS] - [[Information]]
-- Populates randomly a set amount of bezier curves.
-- The more beziers, the prettier and the laggier it'll be.
-- The amount of segments is also chosen at random between set values.
gradiantCurves = {}
for curve=1, c_bezierCurveCount, 1 do
	gradiantCurves[curve] = {
		{},
		{
			createBackgroundAnimation(c_minRed, c_maxRed),
			createBackgroundAnimation(c_minGreen, c_maxGreen),
			createBackgroundAnimation(c_minBlue, c_maxBlue),
			createBackgroundAnimation(c_minAlpha, c_maxAlpha),
		},
		{
			createBackgroundAnimation(c_minRed, c_maxRed),
			createBackgroundAnimation(c_minGreen, c_maxGreen),
			createBackgroundAnimation(c_minBlue, c_maxBlue),
			createBackgroundAnimation(c_minAlpha, c_maxAlpha),
		},
		createBackgroundAnimation(c_minSizing, c_maxSizing),
	}
	curve = gradiantCurves[curve]
	
	-- Defines a set amount of points per bezier curve, at random coordinates
	for segment=1, c_pointsPerCurve do
		segments = curve[c_curveSegments]
		segments[segment] = {
			createBackgroundAnimation(c_minX, c_maxX),
			createBackgroundAnimation(c_minY, c_maxY)
		}
	end
end