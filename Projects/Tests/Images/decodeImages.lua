-- [BRS] - [[ Information ]] --
-- `26/03/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Paste a BRS base64 encoded image into the script, and obtain the rectangles and setColors you need to draw it regularly.
-- ## Where is this used?
-- When you have icons from a project, and want to modify them.

-- [BRS] - [[ Imports ]] --
require("Functions.Base64.Images.decodeColoredImage")
require("Functions.Base64.Images.drawColoredImage")
require("Functions.Monitor.Utils.thattiguyColorCorrection")

-- [BRS] - [[ Constants ]] --
g_base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/!@#_~|&*-:=?"

-- [BRS] - [[ Globals ]] --
g_inverseTable = {}

-- Paste in here the base64 encoded image you want to obtain rectangles from.
g_toDecode = "QBSWD/LBM@A:BBQCDDOBMBFGKHGBIIGBHJFBGKFBGLECFMEF?B:BAQBKGCBIHCBHIBBGJBBFLBB?C:BDCBDEJBQHBBOICBMJCBLKBBKLBBJNBBFREB"

-- [BRS] - [[ Functions ]] --
function uncorrectColorCorrection(color)
    return g_inverseTable[color]
end

-- [BRS] - [[ OnDraw ]] --
function onDraw()    
    if g_toDecode~="" then
		drawableImage = decodeImage(g_toDecode)

		for i=1, #drawableImage do
			bundle = drawableImage[i]
			color = bundle[1]
			rectangles = bundle[2]

			r = uncorrectColorCorrection(color[1])
			g = uncorrectColorCorrection(color[2])
			b = uncorrectColorCorrection(color[3])

			print("setColor("..r..", "..g..", "..b..")")
			for _,v in pairs(rectangles) do
				print("drawRectF("..v[1]..","..v[2]..","..v[3]..","..v[4]..")")
			end
			print("")
		end
		-- [BRS] - Clears the string so its printed only once.
		g_toDecode = ""
	end
    drawImage(0, 0, drawableImage)
end

-- [BRS] - [[   Before script   ]] --

-- [BRS] - Data is lost when we correct a color and then uncorrect it, due to floating point precision.
-- however, it is possible to just store all the conversions and find the nearest match lol.
-- You also loose information in the downscaling to 64 values rather than 255. But closest match can be found.
for i = 0,255 do
    corrected = correctColor(i)
	transformed = math.floor((corrected/255)*63)+1
	decoded = ((transformed-1)/63)*255
    
    if g_inverseTable[decoded] == nil then
        g_inverseTable[decoded] = i
    end
end