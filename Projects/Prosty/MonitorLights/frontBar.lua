g_screenOn = false
g_screenWidth = 0
g_screenHeight = 0

g_blinkAnimation = 0
g_drlBootAnimation = 0
g_drlAnimationLeft = 0
g_drlAnimationRight = 0
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
g_bootAnimation = 0
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
    
    DRL = g_screenOn
    spotlight = input.getBool(4)
    blinkerR = input.getBool(6)
    blinkerL = input.getBool(7)
    blinking = input.getBool(5)
	RGB = input.getBool(8)
	
	offset = offset + (frequency)/10
	if offset > 9.5 then
		offset = 0
	end
    
    -- spotlight passthrough
    output.setNumber(2, input.getNumber(6))
    output.setNumber(1, input.getNumber(8))
    
     -- Boot animations
    target = 0
    if g_screenOn then
    	target = 1
	    bootPos = 1-math.sin(g_bootAnimation*1.57+1.57)
    else
    	target = 0
    end
    g_bootAnimation = linear(g_bootAnimation, target, 0.015)
    booted = g_bootAnimation == 1
    off = g_bootAnimation == 0
    
    
    if not booted then
		g_tailightAnimation = lerp(g_tailightAnimation, 0, 0.2)
		g_brakelightAnimation = lerp(g_brakelightAnimation, 0, 0.2)
		g_reverselightAnimation = lerp(g_reverselightAnimation, 0, 0.2)
		g_mustBeRearAnimation = lerp(g_mustBeRearAnimation, 0, 0.2)
	end
    
	-- DRL animation
	if (DRL and booted) then
		g_drlBootAnimation = lerp(g_drlBootAnimation, 1, 0.2)
	else
		g_drlBootAnimation = lerp(g_drlBootAnimation, 0, 0.2)
	end
	
	if (DRL and booted) and not blinkerR then
		target = 1
	else
		target = 0
	end
	g_drlAnimationRight = lerp(g_drlAnimationRight, target, 0.2)
	
	if (DRL and booted) and not blinkerL then
		target = 1
	else
		target = 0
	end
	g_drlAnimationLeft = lerp(g_drlAnimationLeft, target, 0.2)
	
	if blinking then
		if g_blinkAnimation < 1 then
			g_blinkAnimation = g_blinkAnimation + 0.2
		end
	else
		g_blinkAnimation = 0
	end
	
	-- Blinker
	if blinkerR and booted then
		g_blinkAnimationR = 1
	else
		if g_blinkAnimationR > 0 then
			g_blinkAnimationR = g_blinkAnimationR - 0.2
		end
	end
	
	if blinkerL and booted then
		g_blinkAnimationL = 1
	else
		if g_blinkAnimationL > 0 then
			g_blinkAnimationL = g_blinkAnimationL - 0.2
		end
	end
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
    	sequence = (g_blinkAnimation*3)
    	if sequence > 0 then
	    	for i=0,sequence do
				SetColor(255*g_blinkAnimationL,128*g_blinkAnimationL,0)
			
				blinker(((i)*2)+25, 19, 0, g_blinkAnimationL)
				blinker(((i)*2)+25, 8, 1, g_blinkAnimationL)
	    	end
	    end
    end
    
    if g_blinkAnimationR > 0 then
    	sequence = (g_blinkAnimation*3)
    	if sequence > 0 then
	    	for i=0,sequence do
				SetColor(255*g_blinkAnimationR,128*g_blinkAnimationR,0)
			
				blinker(((3-i)*2), 19, 1, g_blinkAnimationR)
				blinker(((3-i)*2), 8, 0, g_blinkAnimationR)
	    	end
	    end
    end
    
    -- middle light bar
    if g_drlBootAnimation > 0.01 then
    	--RectF(0,25-(1-g_tailightAnimation)*-8,32,7)
    	for i=0, g_drlBootAnimation*11, 1 do
    		for y=0, 7, 1 do
    			ratio = 1-(((y-3.5)^2)/12.25)
    			if ratio > 0 then
	    			full = 100*g_drlBootAnimation * ratio
	    			SetColor(full,full,full)
	    			RectF(15-i, 12+y, 1, 1)
	    			RectF(16+i, 12+y, 1, 1)
    			end
    		end
    	end
    end
    
    -- DRLs
    if g_drlAnimationRight > .01 then
		full = 255*g_drlAnimationRight
		SetColor(full,full,full)
		
		x = math.ceil(-7 + g_drlAnimationRight * 7)
		
		RectF(x, 9, 3, 1)
		RectF(x, 10, 4, 1)
		RectF(x, 11, 5, 1)
		RectF(x, 12, 6, 1)
		
		RectF(x, 19, 6, 4)
    end
    
    if g_drlAnimationLeft > .01 then
    	speedFix = g_drlAnimationLeft
		full = 255*speedFix
		SetColor(full,full,full)
		
		x = math.floor(33 - speedFix * 7)
		
		RectF(x+3, 9, 3, 1)
		RectF(x+2, 10, 4, 1)
		RectF(x+1, 11, 5, 1)
		RectF(x, 12, 6, 1)
		
		RectF(x, 19, 6, 4)
		-- DRLpod(32 - speedFix * 7, 9)
		-- DRLpod(32 - speedFix * 7, 19)
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
    --BRS(9, 26)
    
end

function blinker(x,y, dir, colorRatio)

	SetColor(255*colorRatio,128*colorRatio,0)
	
	for i=0, 4 do
		if dir == 1 then
			RectF(x,i+y,1,1)
		else
			RectF(x,(4-i)+y,1,1)
		end
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
			turnRed = (g_bootAnimation - 0.7)/0.29
			SetColor(255*(turnRed),0,0)
		end
	end
	
	if booted then
		SetColor(255*(1-g_drlBootAnimation),0,0)	
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
	-- print(pos)

    r = math.sin(frequency * pos + 0) * 0.5 + 0.5
    g = math.sin(frequency * pos + 2 * math.pi / 3) * 0.5 + 0.5
    b = math.sin(frequency * pos + 4 * math.pi / 3) * 0.5 + 0.5

    -- Now apply gamma correction
    gamma = 2
    r = r ^ gamma
    g = g ^ gamma
    b = b ^ gamma

    return r*255, g*255, b*255
end