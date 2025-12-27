-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Creates a random coordinate object in a coordinate table object.
-- Created within the min and max x,y background configuration.
-- ### Used for
-- Animating Bezier curve's coordinate points.
-- ### @Input
-- ##### - `positionObject`  : `table` = {x,y}
function randomCoordinate(positionObject)
	positionObject[c_xIndex] = math.random(c_minX, c_maxX)
	positionObject[c_yIndex] = math.random(c_minY, c_maxY)
end