require("Functions.Animations.Framework.quintInOutAnimation")
require("Projects.Roadworks.ElectricCharger.functions.background.randomCoordinate")
require("Projects.Roadworks.ElectricCharger.functions.background.newSegmentGoal")
require("Projects.Roadworks.ElectricCharger.functions.background.newBackgroundAnimation")

-- [BRS] - [[Information]]
-- Populates randomly a set amount of bezier curves.
-- The more beziers, the prettier and the laggier it'll be.
-- The amount of segments is also chosen at random between set values.
gradiantCurves = {}
for curve=1, c_bezierCurveCount, 1 do
	gradiantCurves[curve] = {
		{},
		{
			newBackgroundAnimation(0,0),
			newBackgroundAnimation(0,0),
			newBackgroundAnimation(0,0),
			newBackgroundAnimation(0,0),
		},
		{
			newBackgroundAnimation(0,0),
			newBackgroundAnimation(0,0),
			newBackgroundAnimation(0,0),
			newBackgroundAnimation(0,0),
		},
		newBackgroundAnimation(0,0),
	}
	curve = gradiantCurves[curve]
	
	for segment=1, math.random(c_minSegmentCount, c_maxSegmentCount), 1 do
		segments = curve[c_curveSegments]
		segments[segment] = {
			{0,0},
			newBackgroundAnimation(0,0),
			newBackgroundAnimation(0,0)
		}
		randomCoordinate(segments[segment][c_segmentCurrentPos])
		newSegmentGoal(segments[segment], c_segmentXAnimation, c_minX, c_maxX)
		newSegmentGoal(segments[segment], c_segmentYAnimation, c_minY, c_maxY)
	end
end