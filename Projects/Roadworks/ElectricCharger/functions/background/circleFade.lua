require("Functions.Animations.Framework.lerpAnimation")

function circleFade(x,y, x2, y2, startColor, endColor, sizing, startRatio, endRatio, distanceBetweenPoints, deltaX, deltaY)
	drawingIncrementRatio = 1/(distanceBetweenPoints/5)
	ratioDiff = endRatio-startRatio
	
	startRed = startColor[1][c_animationCurrent]
	startGreen = startColor[2][c_animationCurrent]
	startBlue = startColor[3][c_animationCurrent]
	startAlpha = startColor[4][c_animationCurrent]
	
	endRed = endColor[1][c_animationCurrent]
	endGreen = endColor[2][c_animationCurrent]
	endBlue = endColor[3][c_animationCurrent]
	endAlpha = endColor[4][c_animationCurrent]
	
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
		red   = lerpAnimation(startRed, endRed, globalRatio)
		green = lerpAnimation(startGreen, endGreen, globalRatio)
		blue  = lerpAnimation(startBlue, endBlue, globalRatio)
		alpha = lerpAnimation(startAlpha, endAlpha, globalRatio)
		screen.setColor(red, green, blue, alpha)
		-- Calculates the size of the circle based on its position on the line.
		-- Ensures circles are bigger at the center of the line
		-- Function shaped like an eye. Original function couldn't be used
		-- due to computing discrepancies between Desmos and Pony IDE.
		-- Better computation times than using sin functions.
		effectRatio = (-((2*globalRatio - 1)^2) + 1)
		screen.drawCircleF(circleX, circleY, effectRatio * sizing)
	end
end