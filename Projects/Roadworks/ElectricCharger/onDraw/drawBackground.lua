    -- [BRS] - Bezier background drawing. Does all the curves.
	-- 244 characters used here.
    for curveIndex=1, #gradiantCurves, 1 do
    	curve = gradiantCurves[curveIndex]
    	segments = curve[c_curveSegments]
    	drawBezier(curve, c_bezierSegmentSubsections)
    	
    	-- Handling the curve's own animations
    	handleColorAnimations(curve[c_curveStartColor])
    	handleColorAnimations(curve[c_curveEndColor])
    	
    	sizeAnimation = curve[c_curveSizing]
    	if sizeAnimation[c_animationTimeLeft] == 0 then -- we need a new y goal.
    		curve[c_curveSizing] = handleAnimationEnd(sizeAnimation, c_minSizing, c_maxSizing)
    	end
    	animate(sizeAnimation)
    	
    	-- Move all segments towards their targets
    	for segmentIndex=1, #segments do
    		segment = curve[c_curveSegments][segmentIndex]
    		livePos = segment[c_segmentCurrentPos]
    		
    		-- X management
    		xAnimation = segment[c_segmentXAnimation]
    		if xAnimation[c_animationTimeLeft] == 0 then -- we need a new x goal.
    			newSegmentGoal(segment, c_segmentXAnimation, c_minX, c_maxX)
    		else
    			livePos[c_xIndex] = xAnimation[c_animationCurrent]
    		end
    		
    		-- Y management
    		yAnimation = segment[c_segmentYAnimation]
    		if yAnimation[c_animationTimeLeft] == 0 then -- we need a new y goal.
    			newSegmentGoal(segment, c_segmentYAnimation, c_minY, c_maxY)
    		else
    			livePos[c_yIndex] = yAnimation[c_animationCurrent]
    		end
    		
    		-- animate all animations
    		animate(xAnimation)
    		animate(yAnimation)
    	end
    end