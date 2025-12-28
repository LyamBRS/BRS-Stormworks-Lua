    -- [BRS] - Bezier background drawing. Does all the curves.
	-- 192 characters used here.
    for curveIndex=1, #gradiantCurves, 1 do
    	curve = gradiantCurves[curveIndex]
    	segments = curve[c_curveSegments]
    	drawBezier(curve, c_bezierSegmentSubsections)
    	
    	-- Handling the curve's own animations
    	handleColorAnimations(curve[c_curveStartColor])
    	handleColorAnimations(curve[c_curveEndColor])
    	
    	sizeAnimation = curve[c_curveSizing]
    	if sizeAnimation[c_animationTimeLeft] == 0 then -- we need a new y goal.
    		handleAnimationEnd(sizeAnimation, c_minSizing, c_maxSizing)
    	end
    	animate(sizeAnimation)
    	
    	-- Move all segments towards their targets
    	for segmentIndex=1, #segments do
    		segment = curve[c_curveSegments][segmentIndex]
    		
			for coord=1,2 do
				coordinateAnimation = segment[coord]
				currentRange = g_bezierPointCoordinateRanges[coord]

				if coordinateAnimation[c_animationTimeLeft] == 0 then
					handleAnimationEnd(
						coordinateAnimation,
						currentRange[1],
						currentRange[2]
					)
				end
				animate(coordinateAnimation)
			end
    	end
    end