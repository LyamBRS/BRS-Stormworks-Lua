----------------------------------------------
----------------------------------------------
-- WARNING -- QUALITY
----------------------------------------------
--- this microcontroller and lua code was made
--- BEFORE i made my Lua code open source and
--- created the simple preprocessor. Stuff is
--- minified within and DOES NOT follow good
--- lua best practices.
--- Use at your own risk.
----------------------------------------------
-------------------------------------------------


dr = screen.drawRectF 
sc = screen.setColor
dl = screen.drawLine

gn = input.getNumber 
gb = input.getBool

ob = output.setBool
on = output.setNumber

mr = math.random

t=true
f=false
--trackSpaceShip = {}
------------------------------------------- Variables
MovementMultiplier = 1
aspectRatio = 0
playerSpeed = 3
warpingCount = 0
spaceshipOffset = 5
-------------------------------------------
-- 100 = furthest point -- 1 Znear
Znear   = .1
Zfar	= 500
Zfactor = Zfar/(Zfar-Znear)
Zlimit  = Znear-20

score = 0
FOV     = 1.59  --1/math.tan(.56)
screenW = 1
screenH = 1
ZPerspective = 0
explosion = 0
osX,osY,osZ=0,0,0
_=255

-------------------------------------------
PlayerCoords = {
				0,-- X
				1-- Y
				--.1--,-- Z
				--0,-- Cam U/D
				--0,-- Cam L/R
			   }

CoordsMax = {
			 25,
			 25--,
			 --0,
			 --3.14,
			 --0,
			}
			
Xmax = 25
Ymax = 25

p={80,80,80}
colours = {
			{0,0,0},
			p,
			p,
			p,
			p,
			{_,_,_}	
		  }	
		  
lineColor = {0,255,0}
rotate = 0
rotateB=0
wantedColor = {0,255,0}
-------------------------------------------
wantedoffset = 5
VisualDistortionX = 0
VisualDistortionY = 0
wantedVDX=0
wantedVDY=0
rotatedSpeed=0
wantedRotateSpeed=0
cubeColor = {}
function onTick()
	screenW     = gn(1)
	screenH     = gn(2)
	aspectRatio = screenH/screenW
	
	test = gn(27)
	
	if cubeColor[1]==nil then 
		cubes={}
		for i=1,10,1 do	
			cubes[i]=randomizeCube()
			cubeColor[i]=randomizeColor()
		end
	end
	
	for i=1,#cubes,1 do
		cubes[i] = moveObject(cubes[i],3,2)
	end
	
	if math.random(0,300)==10 then
		
		wantedVDX = math.random(-100,100)/1 -- VDX = Visual Distortion X
		wantedVDY = math.random(-100,100)/1
		
		wantedRotateSpeed = math.random(-10,10)/1000
		
		wantedColor[1]=mr(0,255)
		wantedColor[2]=mr(0,255)
		wantedColor[3]=mr(0,255)
	end
	
	VisualDistortionX = Lerp(VisualDistortionX, wantedVDX, 0.01)
	rotatedSpeed = Lerp(rotatedSpeed, wantedRotateSpeed, 0.01)
	
	rotate = rotate + rotatedSpeed
	if rotate>6.27 then rotate = 0 end
	
	rotateB = rotateB + 0.01
	if rotateB>6.27 then rotateB = 0 end
	if rotateB<0 then rotateB = 6.27 end	

	for i=1,3,1 do
		lineColor[i]=Lerp(lineColor[i],wantedColor[i],0.01)
	end
	
	PlayerCoords={0,25*(math.cos(rotateB+2.02)*2),1}
end

function onDraw()
------------------------------------------- draw background lines

	for i=Zfar,Znear,-1 do

		ratio = 1-(i/Zfar)^0.5
		
		for z=#cubes,1,-1 do
			if i==cubes[z][1][8][3]then
				Draw3DObject(cubes[z],cubeColor[z],ratio)			
			end
		end
		
		sc(lineColor[1]*ratio,lineColor[2]*ratio,lineColor[3]*ratio)
		
		A = {-CoordsMax[1],CoordsMax[2],i}
		B = { CoordsMax[1],CoordsMax[2],i}
		
		--A = RotatePoints(A,2,1,rotate+((i/Zfar)*1.57))
		--B = RotatePoints(B,2,1,rotate+((i/Zfar)*1.57))				

		draw3DLine(A,B)
	end
end
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
function draw3DLine(coordinatesA,coordinatesB)

	X1,Y1 = w3Dto2D(coordinatesA)
	X2,Y2 = w3Dto2D(coordinatesB)
	
	dl(X1,Y1,X2,Y2)
	dl(X1,Y1+1,X2,Y2)
	dl(X1,Y1,X2,Y2+1)	
end

function moveObject(object,axe,delta)

        for triangles=1,#object[1],1 do
                object[1][triangles][axe] = object[1][triangles][axe] - delta
        end
        
        if object[1][8][3]<Znear then object = randomizeCube()end
        
        return object
end
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
function RotatePoints(coords,coordA,coordB,angle)
        
        temp = coords

        for i=1,#temp,1 do        
                -- Get original coords to translate
                cA = temp[coordA]
                cB = temp[coordB]                
                
                distance      = math.sqrt((cA^2)        +        (cB^2))
                OriginalAngle = math.atan(cA,cB)+angle
                
                temp[coordA] = (math.sin(OriginalAngle)*distance)
                temp[coordB] = (math.cos(OriginalAngle)*distance)
                
        end

        return temp
end
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
function randomizeCube()
	

	cubeW = 6
	cubeH = 6
	return CreateRectangle(
							mr(-Xmax+cubeW,Xmax), -- X
							mr(0,(Ymax)-cubeH), -- Y
							mr(500,900),					-- Z
							cubeW,							-- Width
							cubeH,							-- Height
							mr(2,10)						-- Lenght
						  )
end
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
function Draw3DObject(object,colorTable,a)
	if a~=nil then b=a else b=1 end
	if object ~= nil then
	
		-- Itterate through each triangle coords groupe
		for faces=2,#object,1 do
			
			objectFaces = object[faces]
			
			if type(objectFaces)=="table" then
				--colour = math.ceil((faces-1)/2)
				tempC = colorTable[math.ceil((faces-1)/2)]
				sc(
					tempC[1]*b,
					tempC[2]*b,
					tempC[3]*b
				  )
			  
				-- Go through each sets of 3 coordinates of the face
				for triangles=1,#objectFaces,3 do
					draw2DTriangle(objectFaces)
				end
			end
		end
	end
end
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
RED = 0
function draw2DTriangle(coords3D)
	
	u = {0,0,0}
	v = {0,0,0}
	
	RED = 0
	for S=1,3,1 do
		u[S],v[S] = w3Dto2D(coords3D[S])
	end
	screen.drawTriangleF(u[1],v[1], u[2],v[2], u[3],v[3])
	
	if RED==1 then
		sc(100,100,100)
		screen.drawTriangle(u[1],v[1], u[2],v[2], u[3],v[3])
	end
end
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
function randomizeColor()

sus = {mr(0,255),mr(0,255),mr(0,255)}
side = {sus[1]/3,sus[2]/3,sus[3]/3,}
	
local colours = {
			{0,0,0},
			side,
			side,
			side,
			side,
			sus	
		  }		
	
	return colours
end
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
function w3Dto2D(worldCoord)
	-- Get world coordinates
	
	local fakecoords = {}
	for i=1,3,1 do
		fakecoords[i]=worldCoord[i]
	end
	
	fakecoords = RotatePoints(fakecoords, 2, 1, rotate+((1-(fakecoords[3]/Zfar))*3.14))
	
	Z = fakecoords[3]+Znear+3

	
	
	if Z<Znear then
		Z = Znear+playerSpeed
		
		if screen ~= nil and Warp==f and GameStarted then
			sc(_,0,0)
			RED = 1
		end
	end
	
	Xoffset = VisualDistortionX*(math.sin((Z/Zfar)*12))
	Yoffset = 25*(math.sin(rotateB+((Z/Zfar)*6.28)*2))	
	
	X = ((fakecoords[1]+PlayerCoords[1]+Xoffset) * aspectRatio * FOV)
	Y = ((fakecoords[2]+PlayerCoords[2]+Yoffset) * FOV)
	
	if Z~=0 then
		Z = (Z * Zfactor) - (Znear * Zfactor)
		X = X/Z
		Y = Y/Z
	end
	
	--Scale to view
	--X = (X+1)*(screenW/2)
	--Y = (Y+1)*(screenH/2)
	
	-- Return 2D screen ajusted coordinates
	return (X+1)*(screenW/2),(Y+1)*(screenH/2)
end
-- To reduce characters. Augments stack tho.
function draw2LineToHorizon(a1,a2,b1,b2)
	x1,y1 = w3Dto2D({a1,b1,Znear})
	x2,y2 = w3Dto2D({a1,b1,Zfar})
	x3,y3 = w3Dto2D({a2,b2,Znear})
	x4,y4 = w3Dto2D({a2,b2,Zfar})	
	
	dl(x1,y1,x2,y2)
	dl(x3,y3,x4,y4)
end
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
function CreateRectangle(oX,oY,oZ, sW,sH,sD)
	
	--Dimension offset (wanted sizes)
	dZ = oZ + sD
	dY = oY - sH
	dX = oX - sW
	
	A = {oX,oY,oZ} -- 0,0,0
	B = {dX,oY,oZ} -- 1,0,0
	C = {oX,oY,dZ} -- 0,0,1
	D = {dX,oY,dZ} -- 1,0,1
	
	E = {oX,dY,oZ} -- 0,1,0
	F = {dX,dY,oZ} -- 1,1,0
	G = {oX,dY,dZ} -- 0,1,1
	H = {dX,dY,dZ} -- 1,1,1
	
	--[[
	 Front is always drawn last.
	 Add front to table
	 Check if above or below nothing if within L/R
	 check if right or left, nothing if within U/D
	 
	 From left:
			midTop = {12,13,,7}
			middle = {5,7}
			midBot = {5,3,7}
	 From right:
	 
	 From top:
	 
	 From bottom:
	]]
	
	return
	{
	{A,B,C,D,E,F,G,H}, -- 1 Global pointers
	
	{C,D,H}, -- 2,3 back
	{C,G,H},

	{A,B,D}, -- 4,5 bottom
	{A,C,D},
	
	{B,D,H}, -- 6,7 right
	{B,F,H},
	
	{A,E,G}, -- 8,9 left
	{A,C,G},
	
	{E,G,H}, -- 10,11 top
	{E,F,H},	
	
	{A,E,F}, -- 12,13 front
	{A,B,F}
	}
end
--[[---------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
function CreateGem(oX,oY,oZ)
	
	A = {oX,  oY-2,oZ-1}
	B = {oX-2,oY,  oZ-3}
	C = {oX,  oY,  oZ}	
	D = {oX+2,oY,  oZ-3}
	E = {oX,  oY+2,oZ-1}
	
	return {
			{A,B,C,D,E},
			
			--back
			{D,B,E},
			{D,B,A},
			
			{D,E,C}, -- left
			{D,A,C},
			
			{E,C,B}, -- right
			{C,B,A}
	       }
end

function randomizeGem()
	return CreateGem(-PlayerCoords[1],PlayerCoords[2], 500)
end
]]
--[[---------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
function BoxCollision3D(AcoordFR,AcoordBL,BcoordFR,BcoordBL)

	return
		-- X
		BcoordFR[1] > AcoordBL[1] and BcoordFR[1] < AcoordFR[1] and
		-- Y
		BcoordFR[2] > AcoordBL[2] and BcoordFR[2] < AcoordFR[2] and
		-- Z
		BcoordFR[3] > AcoordFR[3] and BcoordFR[3] < AcoordBL[3]
end
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------]]
function Lerp(a, b, t)return a + (b - a) * t end
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
------------------------------------------- First rectangle generation
------------------------------------------- and lines generations
cubes = {}
speedLines = {}
Gem = {}
for i=1,20,1 do
	cubes[i]	  = randomizeCube()
	speedLines[i] = i*(Zfar/19)
end
------------------------------------------- SpaceShip object.
Table={55,0,110}

spaceShipColors = {
					{25,0,90},	
					{55,25,110},	
					{55,40,110},
					Table,
					Table
				  }

spaceShip = CreateRectangle(0,0,0, 2,2,2)
a = {0,125,_}
gemColor = {a,a,a}