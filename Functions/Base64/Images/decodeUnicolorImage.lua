require("Functions.Strings.split")
require("Functions.Base64.Conversions.letterToNumber")
-- [BRS] - [[ Information ]] --
-- `26/03/13`
-- ### Description
-- Decodes base64 string encoded images, into drawable images.
-- Colored images simply wont have colors, but they will work through this function.
--
-- ### Used for
-- Drawing complicated icons without saving all their coordinates directly in the code.
-- Or receiving icons from BRIO, then displaying them.
-- You utilize this only if the image has colors AND is only for specific dimensions.
-- ### @Input
-- ##### - `encoded` : `string`
-- Encoded image that follows the following encoding:
-- 
-- `Color definitions @ color index: rectangle dimensions ? color index: rectangle dimensions`
--
-- `RGB1 RGB2 RGB3 @ 1 : x,y,w,h x,y,w,h ? 2: x,y,w,h`
--
-- `RGBRGBRGB@1:XYWHXYWH?2:XYWH`
-- ### @Returns
-- ##### 1. `image` : `table`
-- {{{},{{x,y,w,h}, {x,y,w,h}}}
function decodeUnicolorImage(encoded)
    -- [BRS] - Seperates the color definitions from their rectangle usages
    colorsSplit = split(encoded, "@")
    colors = {}
    image = {}

    -- [BRS] - Bundle separation, color:xywhxywhxywh
	for _,v in pairs(split(colorsSplit[2],"?")) do
		i = #image+1
		bundle = split(v,":")
		image[i] = {{0,0,0},{}}

        -- [BRS] - For every groups of rectangle positions (thus the increase of 4)
		for j=1,#bundle[2],4 do
			temporary = {}
			rectangle = bundle[2]:sub(j,j+3)
			for c=1,4 do
				temporary[c] = numberFromBase64(rectangle:sub(c,c))-1
			end
			image[i][2][j] = temporary
		end
    end
    return image
end