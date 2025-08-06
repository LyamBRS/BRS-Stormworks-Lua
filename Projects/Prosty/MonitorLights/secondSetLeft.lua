g_screenOn = false

g_drlBootAnimation = 0
g_blinkAnimationL = 0
g_blinkAnimationR = 0
g_tailightAnimation = 0
g_brakelightAnimation = 0
g_reverselightAnimation = 0

g_blinkAnimationLBrake = 0
g_blinkAnimationRBrake = 0

trunkLight = 0
gear = 0
trunkPivot = 0

function onTick()
    -- BRS VEHICLE LIGHTS COLOR FRAMEWORK --
    g_screenOn = input.getBool(32)
    trunkPivot = input.getNumber(14)

    gear = input.getNumber(11)

    -- So BROS composite can reach ur right monitor lua.
    for i=0, 32 do
        output.setNumber(i, input.getNumber(i))
        output.setBool(i, input.getBool(i))
    end
    
    if gear == 1 then -- you're in park and you have a regular trunk light.
        if trunkPivot > 0 then
            g_rgbAverage[1] = lerp(g_rgbAverage[1], 255, 0.1)
            g_rgbAverage[2] = lerp(g_rgbAverage[2], 255, 0.1)
            g_rgbAverage[3] = lerp(g_rgbAverage[3], 255, 0.1)
        else
            g_rgbAverage[1] = lerp(g_rgbAverage[1], 0, 0.1)
            g_rgbAverage[2] = lerp(g_rgbAverage[2], 0, 0.1)
            g_rgbAverage[3] = lerp(g_rgbAverage[3], 0, 0.1)
        end
    end

    if trunkPivot < 0.01 then
        g_rgbAverage[1] = lerp(g_rgbAverage[1], 0, 0.1)
        g_rgbAverage[2] = lerp(g_rgbAverage[2], 0, 0.1)
        g_rgbAverage[3] = lerp(g_rgbAverage[3], 0, 0.1)
    end
    
    g_screenWidth = 32
    g_screenHeight = 32
    
    totalArea = (g_screenWidth * g_screenHeight)/7
    g_pixelToLightRatio = 1 / totalArea

    output.setNumber(1, g_rgbAverage[1]/255)
    output.setNumber(2, g_rgbAverage[2]/255)
    output.setNumber(3, g_rgbAverage[3]/255)
    -- [END]
    
    DRL = input.getBool(3)
    tailight = input.getNumber(12) > 1
    brake = input.getBool(17)
    reverse = input.getNumber(11) == 0
    blinkerR = input.getBool(15) -- LEFT BLINKER INPUT!!!
    --blinkerL = input.getBool(7)
    -- blinking = input.getBool(5)
    
	if brake then
		g_brakelightAnimation = 1
	else
		g_brakelightAnimation = 0
	end
	
	if reverse then
		g_reverselightAnimation = linear(g_reverselightAnimation, 1, 0.1)	
	else
		g_reverselightAnimation = linear(g_reverselightAnimation, 0, 0.1)	
	end
	
	if tailight then
		g_tailightAnimation = lerp(g_tailightAnimation, 1, 0.2)	
	else
		g_tailightAnimation = lerp(g_tailightAnimation, 0, 0.2)	
	end

	-- Blinker
	if blinkerR then
		g_blinkAnimationR = 1
	else
		if g_blinkAnimationR > 0 then
			g_blinkAnimationR = g_blinkAnimationR - 0.075
		end
	end
end

function onDraw()

    if trunkPivot < 0.01 then
    	return
    end
    
    -- BRS VEHICLE LIGHTS COLOR FRAMEWORK -- [first in onDraw]
    if gear ~= 1 then
        g_rgbAverage = {0,0,0}
    end
    -- [end]
    
    if g_blinkAnimationR > 0 then
    	for i=0,20 do
    		ratio = 1-(i/20)
			SetColor(255*g_blinkAnimationR*ratio,128*g_blinkAnimationR*ratio,0)
			
			RectF(i,17,1,7)
    	end
    end
    
    -- tailight
    if g_tailightAnimation > 0.01 then
    	--RectF(0,25-(1-g_tailightAnimation)*-8,32,7)
    	for i=0, g_tailightAnimation*(16), 1 do
    		for y=0, 7, 1 do
    			ratio = -(1/16) * ((y-4)^2) + 1
    			SetColor(64*g_tailightAnimation * ratio,0,0)
    			RectF(15-i, 24+y, 1, 1)
    			RectF(16+i, 24+y, 1, 1)
    		end
    	end
    end

    -- reverse
    if g_reverselightAnimation > 0.01 then
    	full = 255*g_reverselightAnimation
    	SetColor(full, full, full)
    	RectF(32 - 32*g_reverselightAnimation, 9, 32, 7)
    end
    
    if g_brakelightAnimation > 0.01 then
    	SetColor(255*g_brakelightAnimation,1,1)
    	RectF(0,24,32,8)
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
g_rgbAverage = {0,0,0}

function AddToLightAverage(x, intensity)
	for index=1,3 do
		g_rgbAverage[index] = g_rgbAverage[index] + (g_currentSelectedColor[index] * intensity)
	end
end

function SetColor(r,g,b)
	screen.setColor(r,g,b)
	g_currentSelectedColor = {r,g,b}
end

function RectF(x,y,w,h)
	-- get how many pixels the rectangle is, to calculate color average in one go
	drawnArea = w*h
	areaLightIntensity = g_pixelToLightRatio * h

	for i=0, w do
		AddToLightAverage(x+i, areaLightIntensity)
	end

	screen.drawRectF(x,y,w,h)
end