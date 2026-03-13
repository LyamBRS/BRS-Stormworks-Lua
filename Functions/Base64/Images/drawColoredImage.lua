-- [BRS] - [[ Information ]] --
-- `26/03/13`
-- ### Description
-- Draws an image that was decoded with `decodeColoredImage.lua`
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
function drawImage(x, y, image)
	for i=1, #image do
		color = image[i][1]
		screen.setColor(color[1], color[2], color[3])
		for _,v in pairs(image[i][2]) do
			screen.drawRectF(v[1]+x,v[2]+y,v[3],v[4])
		end
	end
end