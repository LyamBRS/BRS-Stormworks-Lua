-- [BRS] - [[ Information ]] --
-- `26/03/13`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Draw images with rectangles, run the script and obtain their encoded base64 from them.
-- ## Where is this used?
-- When you need to make icons and stuff for a project.

-- [BRS] - [[ Imports ]] --
require("Functions.Base64.Images.decodeColoredImage")
require("Functions.Base64.Images.drawColoredImage")
require("Functions.Monitor.Utils.thattiguyColorCorrection")

-- [BRS] - [[ Constants ]] --
g_base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/!@#_~|&*-:=?"

-- [BRS] - [[ Globals ]] --
g_base64Result = ""
g_savedColors = {}
g_colorString = ""

-- [BRS] - [[ Functions ]] --
function setColor(r,g,b)
	r = correctColor(r)
    g = correctColor(g)
    b = correctColor(b)
    r = math.floor((r/255)*63)+1
	g = math.floor((g/255)*63)+1
	b = math.floor((b/255)*63)+1
	
	found = nil
    -- [BRS] - Tries to find the color. if it does, it was already used before, so we dont save a new one.
	for i=1, #g_savedColors do
		color = g_savedColors[i]
		if color[1]==r and color[2]==g and color[3]==b then
			found = i
		end
	end
	
	if found==nil then
		g_savedColors[#g_savedColors+1] = {r,g,b}
		g_colorString = g_colorString..g_base64:sub(r,r)..g_base64:sub(g,g)..g_base64:sub(b,b)
		found = #g_savedColors
	end
	
	letter = g_base64:sub(found,found)
	if g_base64Result~="" then
		g_base64Result = g_base64Result.."?"
	end
	g_base64Result = g_base64Result..letter..":"
end

function drawRectF(x,y,w,h)
	x = g_base64:sub(x+1,x+1)
	y = g_base64:sub(y+1,y+1)
	w = g_base64:sub(w+1,w+1)
	h = g_base64:sub(h+1,h+1)
	g_base64Result = g_base64Result..x..y..w..h
end

-- [BRS] - [[ OnDraw ]] --
function onDraw()    
    if g_base64Result=="" then
    	setColor(169,45,173)
		drawRectF(1,1,16,2)
		drawRectF(3,3,14,1)
		drawRectF(12,1,5,6)
		drawRectF(10,7,6,1)
		drawRectF(8,8,6,1)
		drawRectF(7,9,5,1)
		drawRectF(6,10,5,1)
		drawRectF(6,11,4,2)
		drawRectF(5,12,4,5)
	
    	setColor(187,62,237)
		drawRectF(1,0,16,1)
		drawRectF(10,6,2,1)
		drawRectF(8,7,2,1)
		drawRectF(7,8,1,1)
		drawRectF(6,9,1,1)
		drawRectF(5,11,1,1)
	
   		setColor(144,41,148)
		drawRectF(1,3,2,1)
		drawRectF(3,4,9,1)
		drawRectF(16,7,1,1)	
		drawRectF(14,8,2,1)
		drawRectF(12,9,2,1)
		drawRectF(11,10,1,1)
		drawRectF(10,11,1,1)
		drawRectF(9,13,1,1)
		drawRectF(5,17,4,1)
		
		
		g_base64Result = g_colorString.."@"..g_base64Result
		print(g_base64Result)
		drawableImage = decodeImage(g_base64Result)
	end
    drawImage(0, 0, drawableImage)
end

-- [BRS] - [[   Before script   ]] --
-- Execution outside of onFunctions.