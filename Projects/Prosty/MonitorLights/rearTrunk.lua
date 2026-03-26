g_screenOn = false
g_screenWidth = 0
g_screenHeight = 0

g_drlBootAnimation = 0
g_blinkAnimationL = 0
g_blinkAnimationR = 0
g_tailightAnimation = 0
g_brakelightAnimation = 0
g_reverselightAnimation = 0
g_mustBeRearAnimation = 0

g_blinkAnimationLBrake = 0
g_blinkAnimationRBrake = 0

booted = false
bootPos = 0
off = false
RGB = false
offset=0
frequency = (3.14/15) * math.pi

function onTick()
    -- BRS VEHICLE LIGHTS COLOR FRAMEWORK --
    g_screenOn = input.getBool(32)
    g_screenWidth = 32
    g_screenHeight = 32
    
    totalArea = (g_screenWidth * g_screenHeight)/7
    g_pixelToLightRatio = 1 / totalArea

    for quadrant=1, 7, 1 do
        channelOffset = (quadrant-1)*3
        output.setNumber(11+channelOffset + 1, g_screenOn and g_rgbAverage[quadrant][1]/255 or 0)
        output.setNumber(11+channelOffset + 2, g_screenOn and g_rgbAverage[quadrant][2]/255 or 0)
        output.setNumber(11+channelOffset + 3, g_screenOn and g_rgbAverage[quadrant][3]/255 or 0)
    end
    -- [END]
    
    mustBeRearLight = true
    DRL = input.getBool(5)
    tailight = input.getBool(2)
    brake = input.getBool(1)
    reverse = input.getBool(3)
    blinkerR = input.getBool(6)
    blinkerL = input.getBool(7)
    blinking = input.getBool(5)
	RGB = input.getBool(8)

	offset = offset + (frequency)/10
	if offset > 9.5 then
		offset = 0
	end

    -- spotlight pass through
    output.setNumber(2, input.getNumber(7))
    output.setNumber(1, input.getNumber(9))

     -- Boot animations
    target = 0
    if g_screenOn then
    	target = 1
	    bootPos = 1-math.sin(g_drlBootAnimation*1.57+1.57)
    else
    	target = 0
    end
    g_drlBootAnimation = linear(g_drlBootAnimation, target, 0.015)
    booted = g_drlBootAnimation == 1
    off = g_drlBootAnimation == 0


    if mustBeRearLight then
    	if brake and booted then
    		g_brakelightAnimation = 1
    	else
    		g_brakelightAnimation = 0
    	end

    	if reverse and booted then
    		g_reverselightAnimation = linear(g_reverselightAnimation, 1, 0.1)	
    	else
    		g_reverselightAnimation = linear(g_reverselightAnimation, 0, 0.1)	
    	end

    	if tailight and booted then
    		g_tailightAnimation = lerp(g_tailightAnimation, 1, 0.2)	
    	else
    		g_tailightAnimation = lerp(g_tailightAnimation, 0, 0.2)	
    	end

    	g_mustBeRearAnimation = lerp(g_mustBeRearAnimation, 1, 0.2)
	else
		g_tailightAnimation = lerp(g_tailightAnimation, 0, 0.2)
		g_brakelightAnimation = lerp(g_brakelightAnimation, 0, 0.2)
		g_reverselightAnimation = lerp(g_reverselightAnimation, 0, 0.2)
		g_mustBeRearAnimation = lerp(g_mustBeRearAnimation, 0, 0.2)
	end

	-- Blinker
	if blinking and blinkerR and booted then
		g_blinkAnimationR = 1
	else
		if g_blinkAnimationR > 0 then
			g_blinkAnimationR = g_blinkAnimationR - 0.075
		end
	end

	if not blinkerR and booted then
		if g_blinkAnimationRBrake > 0 then
			g_blinkAnimationRBrake = g_blinkAnimationRBrake - 0.075
		end
	else
		g_blinkAnimationRBrake = 1
	end

	if blinking and blinkerL and booted then
		g_blinkAnimationL = 1
	else
		if g_blinkAnimationL > 0 then
			g_blinkAnimationL = g_blinkAnimationL - 0.075
		end
	end

	if not blinkerL and booted then
		if g_blinkAnimationLBrake > 0 then
			g_blinkAnimationLBrake = g_blinkAnimationLBrake - 0.075
		end
	else
		g_blinkAnimationLBrake = 1
	end

	output.setNumber(3, g_blinkAnimationL)
	output.setNumber(4, g_blinkAnimationL*0.75)

	output.setNumber(6, g_blinkAnimationR)
	output.setNumber(7, g_blinkAnimationR*0.75)
end

function onDraw()
    -- BRS VEHICLE LIGHTS COLOR FRAMEWORK -- [first in onDraw]
    g_rgbAverage = {{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0}}
    -- [end]

	if RGB then
		for x = -32, 32 do
	    	r, g, b = spectrumRGB(x, 1)
	    	SetColor(r,g,b)
			for y=0,31 do
				if x+y > -1 and x+y < 32 then
			    	RectF(x+y,y,1,1)
				end
			end
		end
		return
	end

    if g_blinkAnimationL > 0 then
    	for i=0,13 do
    		ratio = 1-(i/13)
			SetColor(255*g_blinkAnimationL*ratio,128*g_blinkAnimationL*ratio,0)
			
			if i<2 then
    			RectF(i,0,1,24)
    		else
    			RectF(i,20,1,4)
    		end
    	end
    end
    
    if g_blinkAnimationR > 0 then
    	for i=0,13 do
    		ratio = (i/13)
			SetColor(255*g_blinkAnimationR*ratio,128*g_blinkAnimationR*ratio,0)
			
			if i>11 then
    			RectF(i+18,0,1,24)
    		else
    			RectF(i+18,20,1,4)
    		end
    	end
    end
    
    -- tailight
    if g_tailightAnimation > 0.01 then
    	--RectF(0,25-(1-g_tailightAnimation)*-8,32,7)
    	for i=0, g_tailightAnimation*(16 - (g_reverselightAnimation*5)), 1 do
    		for y=0, 7, 1 do
    			ratio = -(1/16) * ((y-4)^2) + 1
    			SetColor(255*g_tailightAnimation * ratio,0,0)
    			RectF(15-i, 24+y, 1, 1)
    			RectF(16+i, 24+y, 1, 1)
    		end
    	end
    end
    
-- Booting animation
    if not booted and target == 1 then
    	for i=-64,0 do
    		y = i + ((bootPos)*(128))
    		
    		if y > -1 and y < 33 then
    			ratio = 1-((-i)/64)
				SetColor(255*ratio,255*ratio,0)
    			if i<-56 then
    				width = 10-(-(i + 55))
    				RectF(0,y, width, 1)
    				RectF(32-width,y, width, 1)
    			elseif i>=-8 then
    				width = 9-(-i)
    				RectF(width,y, 32-(width*2), 1)
    			else
    				RectF(0,y, 32, 1)
    			end
    		end
    	end
    end
    
    -- Logo
    BRS(9, 26)
    
    -- reverse
    if g_reverselightAnimation > 0.01 then
    	full = 255*g_reverselightAnimation
    	SetColor(full, full, full)
    	RectF(-5 + g_reverselightAnimation*5, 25, 5, 7)
    	RectF(32 - g_reverselightAnimation*5, 25, 5, 7)
    end
    
    if g_brakelightAnimation > 0.01 then
    	SetColor(255*g_brakelightAnimation*g_drlBootAnimation,0,0)
    	RectF(g_blinkAnimationLBrake * 2,0,13 - (g_blinkAnimationLBrake * 2),20)
    	RectF(19,0,13- (g_blinkAnimationRBrake * 2),20)
    end
end

function linear(a,b,t)
	if a < (b-0.01) then
		return a + t
	end
	if a > (b+0.01) then
		return a - t
	end
	return b
end
function lerp(a,b,t) return a * (1-t) + b * t end

-- BRS VEHICLE LIGHTS COLOR FRAMEWORK -- [START]
g_pixelToLightRatio = 0 -- how much % (0-1) of the RGB light is an individual pixel's RGB.
g_currentSelectedColor = {0, 0, 0}
g_rgbAverage = {{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0}}

function AddToLightAverage(x, intensity)
	quadrant = 0
	if x < 27.43 then
		if x < 22.86 then
			if x<18.29 then
				if x<13.72 then
					if x<9.15 then
						if x<4.58 then
							quadrant = 1
						else
							quadrant = 2
						end
					else
						quadrant = 3
					end
				else
					quadrant = 4
				end
			else
				quadrant = 5
			end
		else
			quadrant = 6
		end
	else
		quadrant = 7
	end
	
	for index=1,3 do
		g_rgbAverage[quadrant][index] = g_rgbAverage[quadrant][index] + (g_currentSelectedColor[index] * intensity)
	end
end

function SetColor(r,g,b)
	screen.setColor(r,g,b)
	g_currentSelectedColor = {r,g,b}
end

function RectF(x,y,w,h)
	-- get how many pixels the rectangle is, to calculate color average in one go
	--drawnArea = w*h
	areaLightIntensity = g_pixelToLightRatio * h
	
	for i=0, w do
		AddToLightAverage(x+i, areaLightIntensity)
	end
	
	screen.drawRectF(x,y,w,h)
end

-- [END]

function BRS(x, y)
	
	if not booted then
		newY = bootPos*96 - 6
		if newY < y then
			y = newY
			SetColor(0,0,0)
		else
			turnRed = (g_drlBootAnimation - 0.7)/0.29
			SetColor(255*(turnRed),0,0)
		end
	end
	
	if booted then
		SetColor(255*(1-g_tailightAnimation),0,0)	
	end
	
	RectF(x, y, 4, 1)
	RectF(x, y+2, 1, 1)
	RectF(x, y+4, 4, 1)
	RectF(x+3, y+1, 1, 1)
	RectF(x+2, y+2, 1, 1)
	RectF(x+3, y+3, 1, 1)
	
	x = x + 5
	
	RectF(x, y, 4, 1)
	RectF(x, y+2, 1, 1)
	RectF(x, y+4, 1, 1)
	RectF(x+3, y+1, 1, 1)
	RectF(x+2, y+2, 1, 1)
	RectF(x+3, y+3, 1, 2)
	
	x = x + 5
	
	RectF(x+1, y, 3, 1)
	RectF(x, y+2, 4, 1)
	RectF(x, y+4, 3, 1)
	RectF(x, y+1, 1, 1)
	RectF(x+3, y+3, 1, 1)
end
	
function spectrumRGB(pos, direction)
    pos = (pos/32) + offset * direction

    r = math.sin(frequency * pos + 0) * 0.5 + 0.5
    g = math.sin(frequency * pos + 2 * math.pi / 3) * 0.5 + 0.5
    b = math.sin(frequency * pos + 4 * math.pi / 3) * 0.5 + 0.5

    gamma = 2
    r = r ^ gamma
    g = g ^ gamma
    b = b ^ gamma

    return r*255, g*255, b*255
end