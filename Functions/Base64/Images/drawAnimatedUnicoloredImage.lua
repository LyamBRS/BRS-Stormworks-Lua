require("Variables.Monitor.Elements.colors")
require("Variables.Monitor.Elements.colors.red")
require("Variables.Monitor.Elements.colors.green")
require("Variables.Monitor.Elements.colors.blue")
require("Variables.Monitor.Elements.colors.alpha")
require("Variables.Monitor.Elements.surface")
require("Variables.Monitor.Elements.surface.x")
require("Variables.Monitor.Elements.surface.y")
require("Variables.Monitor.Elements.base64")
require("Variables.Animations.current")
-- [BRS] - [[ Information ]] --
-- `26/03/13`
-- ### Description
-- Draws an image that was decoded with `decodeUnicoloredImage.lua`
-- If the image had any color data, its not shown.
-- You must call screen.setColor prior to this function
-- ### Used for
-- Drawing the images decoded from base64. You need a lot of images
-- for this to be worth it, OR to be allowing ur users to change some
-- images
-- ### @Input
-- ##### - `x` : `int` = position on the monitor
-- ##### - `y` : `int` = position on the monitor
-- ##### - `image` : `table` = decoded image
-- ### @Returns
-- nothing
function drawAnimatedUnicoloredImage(element)
	colors = element[c_elementColors][1]
	screen.setColor(
		colors[c_elementColorR][c_animationCurrent],
		colors[c_elementColorG][c_animationCurrent],
		colors[c_elementColorB][c_animationCurrent],
		colors[c_elementColorA][c_animationCurrent]
	)
	image = element[c_elementBase64][1]
	for i=1, #image do
		for _,v in pairs(image[i][2]) do
			screen.drawRectF(
				v[1]+element[c_elementSurface][c_elementSurfaceX][c_animationCurrent],
				v[2]+element[c_elementSurface][c_elementSurfaceY][c_animationCurrent],
				v[3],
				v[4]
			)
		end
	end
end