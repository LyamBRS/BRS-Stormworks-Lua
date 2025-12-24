
--- [CONSTANTS] ---
-- Utilized in coordinate objects.
c_xIndex = 1
c_yIndex = 2

-- Segment object indexes
--[[ segment = {
	{x, y},								-- current, real position
	{start, target, duration, timeLeft}	-- X position animation object
	{start, target, duration, timeLeft} -- Y position animation object
}
--]]
c_segmentCurrentPos = 1
c_segmentXAnimation = 2
c_segmentYAnimation = 3

-- Curve object indexes
--[[ curve = {
	{},				-- all the segments of the curve
	{				-- Starting color
		{animation} -- R
		{animation} -- G
		{animation} -- B
	},
	{				-- Ending color
		{animation} -- R
		{animation} -- G
		{animation} -- B
	}
	{animation} 	-- Sizing
}
--]]
c_curveSegments 	= 1
c_curveStartColor	= 2
c_curveEndColor 	= 3
c_curveSizing		= 4

c_animationStart = 1
c_animationTarget = 2
c_animationOutput = 3
c_animationDuration = 4
c_animationTimeLeft = 5
c_animationFunction = 6

-- Drawing configurations
c_bezierCurveCount = 7
c_bezierSegmentSubsections = 10
c_maxSegmentCount = 6
c_minSegmentCount = 4
c_minAnimationDuration = 560
c_maxAnimationDuration = 960
c_minX = -64
c_maxX = 96+64
c_minY = -64
c_maxY = 64+64

c_minRed = 50
c_maxRed = 255
c_minGreen = 0
c_maxGreen = 50
c_minBlue = 150
c_maxBlue = 255
c_minAlpha = 5
c_maxAlpha = 40

c_minSizing = 30
c_maxSizing = 60

-- Exists to allow for loop to handle all color animations at once.
colorRanges = {
	{c_minRed, c_maxRed},
	{c_minGreen, c_maxGreen},
	{c_minBlue, c_maxBlue},
	{c_minAlpha, c_maxAlpha}
}

--- [  Code  ] ---
function onTick()
    -- your code
end

function onDraw()
    for curveIndex=1, #gradiantCurves, 1 do
    	curve = gradiantCurves[curveIndex]
    	segments = curve[c_curveSegments]
    	drawBezier(curve, c_bezierSegmentSubsections)
    	
    	--screen.setColor(255,255,255)
    	--screen.drawRectF(
    	--	curve[1][c_segmentCurrentPos][c_xIndex],
    	--	curve[1][c_segmentCurrentPos][c_yIndex],
    	--	1,
    	--	1
    	--)
    	
    	-- Handling the curve's own animations
    	handleColorAnimations(curve[c_curveStartColor])
    	handleColorAnimations(curve[c_curveEndColor])
    	
    	sizeAnimation = curve[c_curveSizing]
    	if sizeAnimation[c_animationTimeLeft] == 0 then -- we need a new y goal.
    		curve[c_curveSizing] = handleAnimationEnd(sizeAnimation, c_minSizing, c_maxSizing)
    	end
    	Animate(sizeAnimation)
    	
    	-- Move all segments towards their targets
    	for segmentIndex=1, #segments, 1 do
    		segment = curve[c_curveSegments][segmentIndex]
    		livePos = segment[c_segmentCurrentPos]
    		
    		-- X management
    		xAnimation = segment[c_segmentXAnimation]
    		if xAnimation[c_animationTimeLeft] == 0 then -- we need a new x goal.
    			newSegmentGoal(segment, c_segmentXAnimation, c_minX, c_maxX)
    		else
    			livePos[c_xIndex] = xAnimation[c_animationOutput]
    		end
    		
    		-- Y management
    		yAnimation = segment[c_segmentYAnimation]
    		if yAnimation[c_animationTimeLeft] == 0 then -- we need a new y goal.
    			newSegmentGoal(segment, c_segmentYAnimation, c_minY, c_maxY)
    		else
    			livePos[c_yIndex] = yAnimation[c_animationOutput]
    		end
    		
    		-- Animate all animations
    		Animate(xAnimation)
    		Animate(yAnimation)
    	end
    end
end

--- [TESTS] ---
function circleFade(x,y, x2, y2, startColor, endColor, sizing, startRatio, endRatio, distanceBetweenPoints, deltaX, deltaY)
	
	drawingIncrementRatio = 1/(distanceBetweenPoints/5)
	ratioDiff = endRatio-startRatio
	
	startRed = startColor[1][c_animationOutput]
	startGreen = startColor[2][c_animationOutput]
	startBlue = startColor[3][c_animationOutput]
	startAlpha = startColor[4][c_animationOutput]
	
	endRed = endColor[1][c_animationOutput]
	endGreen = endColor[2][c_animationOutput]
	endBlue = endColor[3][c_animationOutput]
	endAlpha = endColor[4][c_animationOutput]
	
	-- Goes from 0% to 100% of the distance between the 2 coordinates.
	-- Increments in % steps equivalent to a pixel.
	-- Percentages were used to avoid the calculation of the 1/x ration every loop iteration.
	for position=0, 1, drawingIncrementRatio do
		circleX = deltaX * position + x
		circleY = deltaY * position + y
		globalRatio = ratioDiff * position + startRatio
		
		effectRatio = (-((2*globalRatio - 1)^2) + 1)
		size = effectRatio * sizing
		-- Color management
		red   = LerpAnimation(startRed, endRed, globalRatio)
		green = LerpAnimation(startGreen, endGreen, globalRatio)
		blue  = LerpAnimation(startBlue, endBlue, globalRatio)
		alpha = LerpAnimation(startAlpha, endAlpha, globalRatio)
		screen.setColor(red, green, blue, alpha)
		-- Calculates the size of the circle based on its position on the line.
		-- Ensures circles are bigger at the center of the line
		-- Function shaped like an eye. Original function couldn't be used
		-- due to computing discrepancies between Desmos and Pony IDE.
		-- Better computation times than using sin functions.
		effectRatio = (-((2*globalRatio - 1)^2) + 1)
		-- print(effectRatio)

		-- print(globalRatio, ratioDiff, startRatio, endRatio)
		screen.drawCircleF(circleX, circleY, effectRatio * sizing)
	end
	-- print()
end

function newAnimation(start, target)
	duration = math.random(c_minAnimationDuration, c_maxAnimationDuration)
	return {
		start,
		target,
		start,
		duration,
		duration,
		QuintInOutAnimation
	}	
end

-- Once a segment reached its final animation destinations, new ones need to be assigned.
function newSegmentGoal(segment, animIndex, min, max)
	currentAnimation = segment[animIndex]
	segment[animIndex] = handleAnimationEnd(
		currentAnimation,
		min,
		max
	)
end

function handleAnimationEnd(animation, min, max)
	return newAnimation(
		animation[c_animationOutput],	-- Start from the current location
		math.random(min, max)			-- Go to a new location
	)
end

function handleColorAnimations(color)
	for index=1, 4, 1 do
		animation = color[index]
		range = colorRanges[index]

    	if animation[c_animationTimeLeft] == 0 then -- we need a new y goal.
    		color[index] = handleAnimationEnd(animation, range[1], range[2])
    	end
    	Animate(animation)
	end
end

function randomCoordinate(positionObject)
	positionObject[c_xIndex] = math.random(c_minX, c_maxX)
	positionObject[c_yIndex] = math.random(c_minY, c_maxY)
end

-- [ANIMATION FUNCTIONS]
function ExtractAnimation(array)
	return array[c_animationStart],
			array[c_animationTarget],
			array[c_animationOutput],
			array[c_animationDuration],
			array[c_animationTimeLeft],
			array[c_animationFunction]
end

function Animate(animation)
	if animation[c_animationTimeLeft] == 0 then -- ensure output matches wanted target
		animation[c_animationOutput] = animation[c_animationTarget]
		return animation
	end
	start,target,outcome,duration,timeLeft,animationFunction = ExtractAnimation(animation)
	timeLeft=timeLeft-1
	ratio = 1-(timeLeft/duration)
	outcome = animationFunction(start,target,ratio)
	
	animation[c_animationOutput] = outcome
	animation[c_animationTimeLeft] = timeLeft
	return animation
end


-- REPLACE WITH EXISTING LIBRARY FUNCTION
function lerpCoordinate(a, b, t)
    return {
        a[c_xIndex] + (b[c_xIndex] - a[c_xIndex]) * t,
        a[c_yIndex] + (b[c_yIndex] - a[c_yIndex]) * t
    }
end

-- Evaluate a Bezier curve at t using De Casteljau's algorithm
-- points = { {x,y}, {x,y}, ... }
-- t in [0,1]
function bezierPoint(segments, t)
    temp = {}

    -- Copy points
    for i = 1, #segments do
        temp[i] = {
        	segments[i][c_segmentCurrentPos][c_xIndex],
        	segments[i][c_segmentCurrentPos][c_yIndex]
        }
    end

    -- Reduce until one point remains
    n = #temp
    while n > 1 do
        for i = 1, n - 1 do
            temp[i] = lerpCoordinate(temp[i], temp[i + 1], t)
        end
        n = n - 1
    end

    return temp[1]
end

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
			curve[c_curveSizing][c_animationOutput],
			startPointRatio,
			endPointRatio,
			length,
			coordinates[i][5],
			coordinates[i][6]
		)
	end
end

function QuintInOutAnimation(start, target, ratio)
	if ratio<.5 then
		e=16*ratio*ratio*ratio*ratio*ratio
	else
		e=1-((-2*ratio+2)^5)/2
	end
	return LerpAnimation(start,target,e)
end

function LerpAnimation(start, target, ratio)
	return start * (1-ratio) + target * ratio	
end




-- [Post setup operations] --

-- Populates randomly a set amount of bezier curves.
-- The more beziers, the prettier and the laggier it'll be.
-- The amount of segments is also chosen at random between set values.
gradiantCurves = {}
for curve=1, c_bezierCurveCount, 1 do
	gradiantCurves[curve] = {
		{},
		{
			{0,0,0,0,0,QuintInOutAnimation},
			{0,0,0,0,0,QuintInOutAnimation},
			{0,0,0,0,0,QuintInOutAnimation},
			{0,0,0,0,0,QuintInOutAnimation},
		},
		{
			{0,0,0,0,0,QuintInOutAnimation},
			{0,0,0,0,0,QuintInOutAnimation},
			{0,0,0,0,0,QuintInOutAnimation},
			{0,0,0,0,0,QuintInOutAnimation},
		},
		{0,0,0,0,0,QuintInOutAnimation},
	}
	curve = gradiantCurves[curve]
	
	for segment=1, math.random(c_minSegmentCount, c_maxSegmentCount), 1 do
		segments = curve[c_curveSegments]
		segments[segment] = {
			{0,0}, 
			{0,0,0,0,0,QuintInOutAnimation}, 
			{0,0,0,0,0,QuintInOutAnimation}
		}
		randomCoordinate(segments[segment][c_segmentCurrentPos])
		newSegmentGoal(segments[segment], c_segmentXAnimation, c_minX, c_maxX)
		newSegmentGoal(segments[segment], c_segmentYAnimation, c_minY, c_maxY)
	end
end