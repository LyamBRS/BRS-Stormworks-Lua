require("Projects.Roadworks.ElectricCharger.functions.background.bezierPoints")
require("Projects.Roadworks.ElectricCharger.functions.background.circleFade")

-- [BRS] - Does the whole drawing of the random ElectricCharger curves
function drawBezier(curve, steps)
	segments = curve[c_curveSegments]
    prev = bezierPoint(segments, 0)

	coordinates = {}
	totalLength = 0

	-- Figure out the length of each lines being drawn as we populate coordinates to draw after.
    for i = 1, steps do
        t = i / steps
        p = bezierPoint(segments, t)
        coordinates[i] = {
        	prev,
        	p
        }
        prev = p
    end
    
    -- Bezier has been calculated, only need proper distances and total lengths now.
    for i=1, steps do
    	startPoint = coordinates[i][1]
		endPoint = coordinates[i][2]
		
		deltaX = -(startPoint[c_xIndex]-endPoint[c_xIndex])
		deltaY = -(startPoint[c_yIndex]-endPoint[c_yIndex])
		distanceBetweenPoints = math.sqrt(deltaX^2 + deltaY^2)
		coordinates[i][3] = totalLength
		totalLength = totalLength + distanceBetweenPoints
		coordinates[i][4] = distanceBetweenPoints
		coordinates[i][5] = deltaX
		coordinates[i][6] = deltaY
    end

	-- Print the stuff from the parsed coordinates.
	for i=1, steps do
		startPoint = coordinates[i][1]
		endPoint = coordinates[i][2]
		length = coordinates[i][4]
		startingPoint = coordinates[i][3]
		
		-- indicates how much of the line, this segment corresponds to
		startPointRatio = startingPoint / totalLength
		coveringRatio = length / totalLength
		endPointRatio = startPointRatio + coveringRatio
		
		circleFade(
			startPoint[c_xIndex],
			startPoint[c_yIndex],
			endPoint[c_xIndex],
			endPoint[c_yIndex],
			curve[c_curveStartColor],
			curve[c_curveEndColor],
			curve[c_curveSizing][c_animationCurrent],
			startPointRatio,
			endPointRatio,
			length,
			coordinates[i][5],
			coordinates[i][6]
		)
	end
end