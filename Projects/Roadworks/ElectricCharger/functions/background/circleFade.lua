require("Functions.Animations.Framework.lerpAnimation")
require("Variables.Animations.current")

function circleFade(x,y, x2, y2, startColor, endColor, sizing, startRatio, endRatio, distanceBetweenPoints, deltaX, deltaY)
	drawingIncrementRatio = 1/(distanceBetweenPoints/5)
	ratioDiff = endRatio-startRatio

	-- Goes from 0% to 100% of the distance between the 2 coordinates.
	-- Increments in % steps equivalent to a pixel.
	-- Percentages were used to avoid the calculation of the 1/x ration every loop iteration.
	for position=0, 1, drawingIncrementRatio do
		-- circleX = deltaX * position + x
		-- circleY = deltaY * position + y
		globalRatio = ratioDiff * position + startRatio
		
		-- Color management
		-- [BRS] - Equivalent of:
		-- `red = lerpAnimation(startColor, endColor, ratio)`
		-- `setColor(red)`
		-- doing it this way rather than using a bunch of variables for readability, saves `60` minified characters.
		screen.setColor(
			lerpAnimation(startColor[1][c_animationCurrent], endColor[1][c_animationCurrent], globalRatio),
			lerpAnimation(startColor[2][c_animationCurrent], endColor[2][c_animationCurrent], globalRatio),
			lerpAnimation(startColor[3][c_animationCurrent], endColor[3][c_animationCurrent], globalRatio),
			lerpAnimation(startColor[4][c_animationCurrent], endColor[4][c_animationCurrent], globalRatio)
		)
		-- Calculates the size of the circle based on its position on the line.
		-- Ensures circles are bigger at the center of the line
		-- Function shaped like an eye. Original function couldn't be used
		-- due to computing discrepancies between Desmos and Pony IDE.
		-- Better computation times than using sin functions.
		-- [BRS] - [[Minifications]]:
		-- Used to be:
		-- - `circleX = deltaX * position + x`
		-- - `circleY = deltaY * position + y`
		-- - `effectRatio = (-((2*globalRatio - 1)^2) + 1)`
		-- - `screen.drawCircleF(circleX, circleY, effectRatio * sizing)`
		-- Doing it all in the function call does:
		-- - Saves `12` minified characters
		-- - Brings fps from `44~` to `50~`
		screen.drawCircleF(
			deltaX * position + x,
			deltaY * position + y,
			(-((2*globalRatio - 1)^2) + 1) * sizing	-- Ensures the width of the curve is thicker at the middle
		)
	end
end