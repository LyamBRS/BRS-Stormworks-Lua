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
function drawUnicoloredImage(x, y, image)
	for i=1, #image do
		for _,v in pairs(image[i][2]) do
			screen.drawRectF(v[1]+x,v[2]+y,v[3],v[4])
		end
	end
end