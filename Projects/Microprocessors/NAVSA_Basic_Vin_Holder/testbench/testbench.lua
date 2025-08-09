-- [BRS] - [[ Information ]] --
-- `25/08/08`
-- ## Generic info:
-- #### MC : ``
-- #### SN : ``
-- ## What does this do?
-- This microcontroller is a barebone communication testbench that ensures that the basic NAVSA VIN holder properly works and transmits its data when requested
-- with the propre BRIO commands. Its not meant to be pretty or anything of the sorts.
-- ## Where is this used?
-- Used in vehicles that supports VIN and NAVSA grading. For basic vehicles that just want to hold a basic VIN and grade.

-- [BRS] - [[  imports  ]] --
require("Projects.Microprocessors.NAVSA_Basic_Vin_Holder.testbench.imports")

-- [BRS] - [[ variables ]] --
getInfoPressed = false
wasPressed = false
vin = ""
grade = ""

vinReceived = false
gradeReceived = false
answerReceived = false

lastStage = 0
lastInput = 0

liveVin = ""
liveGrade = ""

g_onGoing = false
g_ticksTaken = 0
i = 0

-- [BRS] - [[   mains   ]] --

function onTick()

    -- [BRS] - Identify that BRIO is going
    g_onGoing = g_BRIOMasterData[c_CommandsIndex] ~= false
    if g_onGoing then
        g_ticksTaken = g_ticksTaken + 1
        lastStage = g_BRIOMasterData[c_StageIndex]
        lastInput = g_BRIOMasterData[c_BusInIndex]
    end

    require("Projects.Microprocessors.NAVSA_Basic_Vin_Holder.testbench.brio")

    -- [BRS] - preprogram BRIO data inputs to test the shit.
    -- i = i + 1
    -- if i> 20 then i=0 end
    --     if i==1 then
    --         g_BRIOMasterData[c_BusInIndex] = -4100
    --     elseif i==2 then
    --         g_BRIOMasterData[c_BusInIndex] = 1000
    --     elseif i==3 then
    --         g_BRIOMasterData[c_BusInIndex] = 2000
    --     elseif i==4 then
    --         g_BRIOMasterData[c_BusInIndex] = 3000
    --     elseif i==5 then
    --         g_BRIOMasterData[c_BusInIndex] = -1
    --     elseif i==6 then
    --         g_BRIOMasterData[c_BusInIndex] = 10000
    --     elseif i==7 then
    --         g_BRIOMasterData[c_BusInIndex] = 22222
    --     elseif i==8 then
    --         g_BRIOMasterData[c_BusInIndex] = 33333
    --     elseif i==9 then
    --         g_BRIOMasterData[c_BusInIndex] = 44444
    --     elseif i==10 then
    --         g_BRIOMasterData[c_BusInIndex] = -1000
    --     elseif i==2 then
    --         g_BRIOMasterData[c_BusInIndex] = 0
        -- end

    -- [BRS] - Inputs
    getInfoPressed = input.getBool(1)

    if getInfoPressed and not wasPressed then
        wasPressed = getInfoPressed
        -- Start the analysis process
        BrioSetMasterCommand(g_BRIOMasterData, g_masterCommands, -3100)
        g_ticksTaken = 0
        liveVin = ""
        liveGrade = ""
        vinReceived = false
        gradeReceived = false
        answerReceived = false
        lastInput = 0
        lastStage = 0
    end
    
    if not getInfoPressed then -- reset the button for the next go.
        wasPressed = getInfoPressed
    end

    if g_BRIO_results[-3100] then
        liveVin = g_BRIO_results[-3100][3]
        liveGrade = g_BRIO_results[-3100][4]
    end
end

function onDraw()
    screen.setColor(255, 255, 255)
    screen.drawText(0,2,  "Ongoing: ")
    screen.drawText(0,8,  "Stage:   ")
    screen.drawText(0,14, "Step:    ")
    screen.drawText(0,20, "Received:")
    screen.drawText(0,26, "Sending: ")
    screen.drawText(0,32, "awaited: ")

    printBoolean(45, 2, g_onGoing)
    screen.drawText(45, 8, g_BRIOMasterData[c_StageIndex])
    screen.drawText(45, 14, g_BRIOMasterData[c_StepIndex])
    screen.drawText(45, 20, g_BRIOMasterData[c_BusInIndex])
    screen.drawText(45, 26, g_BRIOMasterData[c_BusOutIndex])
    screen.drawText(45, 32, g_BRIOMasterData[c_awaitedTimeIndex])

    screen.drawText(96, 8, lastStage)
    screen.drawText(96, 20, lastInput)
    printBoolean(96, 26, lastInput==0)


    if not vinReceived then
        screen.setColor(128,60,60)
        screen.drawText(0,64,tostring(liveVin))
    else
        screen.setColor(0,255,0)
        screen.drawText(0,64,tostring(vin))
    end

    if not gradeReceived then
        screen.setColor(128,60,60)
        screen.drawText(0,96,tostring(liveGrade))
    else
        screen.setColor(0,255,0)
        screen.drawText(0,96,tostring(grade))
    end
end

-- [BRS] - [[   Functions   ]] --
function GotAnAnswer()
    answerReceived = true
end

function GotTheVin()
    vinReceived = true
    vin = g_BRIO_results[-3100][3]
    g_BRIO_results[-3100][3] = nil
end

function GotTheGrade()
    gradeReceived = true
    grade = g_BRIO_results[-3100][4]
    g_BRIO_results[-3100][4] = nil
end

function printBoolean(x, y, value)
    if value then
        screen.setColor(0,255,0)
    else
        screen.setColor(255,0,0)
    end
    screen.drawText(x,y, tostring(value))
end