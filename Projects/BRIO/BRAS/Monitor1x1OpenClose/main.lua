-- [BRS] - [[ Information ]] --
-- `25/08/19`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `1`
-- ## What does this do?
-- This is a 1x1 monitor implementation of BRAS for open / close accesses.
-- ## Where is this used?
-- In vehicles that want to remotely access a BRAS managed access.

-- [BRS] - [[  imports  ]] --
require("Variables.BRIO.constants.channel")
require("Variables.BRIO.dataHolders.constants.busOutHolderIndex")
require("Variables.BRIO.dataHolders.constants.busInHolderIndex")
require("Variables.BRIO.functionReturnsHolder")
require("Variables.BRIO.constants.flags.divider")
require("Variables.BRIO.constants.flags.end")
require("Variables.BRIO.commands.masterCommands")
require("Variables.BRIO.dataHolders.brioMasterData")
require("Functions.BRIO.Managers.masterManager")
require("Functions.BRIO.Senders.sendNumber")
require("Functions.BRIO.Senders.sendText")
require("Functions.BRIO.Getter.GetText")
require("Functions.BRIO.Awaiters.awaitNumber")
require("Functions.BRIO.Utils.setMasterCommand")
require("Functions.BRIO.Getter.GetNumber")

require("Variables.Monitor.Touch.coords")
require("Variables.Monitor.Touch.pressing")

require("Variables.BRAS.close")
require("Variables.BRAS.lock")
require("Variables.BRAS.open")
require("Variables.BRAS.success")
require("Variables.BRAS.unlock")
require("Variables.BRAS.unsupported")
require("Variables.BRAS.incorrectPassword")

-- [BRS] - [[ variables ]] --
password = property.getText("Password")
antennaTransmit = false
g_onGoing = false
oldOngoing = false
handshakeSuccess = false
message = "BRAS"
error = false

resetTimer = 0
g_Accesses = {}

receivedAnswer = false 
handshakeAnswer = 0
receivedAccessID = 0
currentAccess = 1

oldLeftArrow = false
oldRightArrow = false
selectedAccess = 1

amountOfAccesses = 0

-- [BRS] - Button data
require("Projects.BRIO.BRAS.Monitor1x1OpenClose.drawingData")

-- [BRS] - [[   mains   ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --

    -- [BRS] - Populate the accesses array from property values.
    require("Projects.BRIO.BRAS.Manager.accessPropertyParser")

    -- [BRS] - Identify that BRIO is going
    g_onGoing = g_BRIOMasterData[c_CommandsIndex] ~= false

    -- [BRS] - Automated message clearing
    if resetTimer > 0 then
        resetTimer = resetTimer - 1
        if resetTimer == 0 then
            Reset()
        end
    end

    -- [BRS] - Debug message management.
    if oldOngoing ~= g_onGoing then -- the communication started or stopped.
        oldOngoing = g_onGoing

        if not g_onGoing and not receivedAnswer then -- We never received an answer
            message = "  No  answer"
            error = true
            resetTimer = 200
        end

        if not g_onGoing and not handshakeSuccess and not error then -- Well, it seems like we stopped communicating but not the full thing happened!
            message = "BRIO error"
            error = true
            resetTimer = 200
        end

        if not g_onGoing and handshakeSuccess then -- we received right proper shit mate
            resetTimer = 200
            message = "ERR Unknown"
            message = handshakeAnswer == 0 and "ANS ERR: 0" or message
            message = handshakeAnswer == c_brasUnsupported and "op not valid" or message
            message = handshakeAnswer == c_brasIncorrectPassword and " Wrong  pass" or message
            message = handshakeAnswer == c_brasSuccess and "ERR: Success" or message
            message = receivedAccessID ~= selectedAccessID and "ERR: ID" or message

            --[BRS] - Putting handshakeAnswer conditions into variables to reuse the boolean results.
            ansIsLocked = handshakeAnswer == c_brasLocked
            ansIsClosed = handshakeAnswer == c_brasClosed
            ansIsOpened = handshakeAnswer == c_brasOpened
            ansIsUnlocked = handshakeAnswer == c_brasUnlocked

            --[BRS] - Your command failed because the status doesnt match what you should receive.
            message = (ansIsLocked and wantedStatus ~= c_brasLocked) and "Locked" or message
            -- message = (ansIsClosed and wantedStatus ~= c_brasClosed) and "ANS ERR: Closed?" or message
            -- message = (ansIsOpened and wantedStatus ~= c_brasOpened) and "ANS ERR: Opened?" or message
            -- message = (ansIsUnlocked and wantedStatus ~= c_brasUnlocked) and "ANS ERR: Unlocked?" or message

            -- message = (ansIsLocked and wantedStatus == c_brasLocked) and "Success: Locked" or message
            message = (ansIsClosed and wantedStatus == c_brasClosed) and "Closed" or message
            message = (ansIsOpened and wantedStatus == c_brasOpened) and "Opened" or message
            -- message = (ansIsUnlocked and wantedStatus == c_brasUnlocked) and "Success: Unlocked" or message
            
            -- [BRS] - there's an error if Success isn't part of the received answer.
            if message ~= "Closed" and message ~= "Opened" then
                error = true
            end
        end
    end

    -- [BRS] - [[ BRIO ]] --
    require("Projects.BRIO.BRAS.StatusChanger.brio")
    require("Projects.BRIO.BRAS.Monitor1x1OpenClose.monitorManagement")
    require("Projects.BRIO.BRAS.Monitor1x1OpenClose.buttonManagement")

    -- [BRS] - [[ Outputs ]] --
    output.setBool(1, antennaTransmit)
    output.setNumber(1, g_ticksTaken)
end

require("Projects.BRIO.BRAS.Monitor1x1OpenClose.onDraw")

-- [BRS] - [[   Functions   ]] --
-- Called when the whole password update exchange successfully occured.
-- This doesn't mean that the password changed, but that the handshake was right!
function HandshakeSuccess()
    handshakeSuccess = true
    receivedAccessID = g_BRIO_results[-3101][8]
    handshakeAnswer = g_BRIO_results[-3101][9]
    g_BRIO_results[-3101] = nil
end

function StopTransmitting()
    antennaTransmit = false
end

function ReceivedAnswer()
    receivedAnswer = true
end

function Reset()
    message = "BRAS"
    handshakeAnswer = 0
    g_ticksTaken = 0
    selectedAccessID = currentAccessID
    antennaTransmit = false
    handshakeSuccess = false
    receivedAnswer = false
    receivedAccessID = 0
    error = false
    resetTimer = 0
end

-- [BRS] - Sets the current color of a target - current color array.
function SetColor(array)
    color = array[2]
    screen.setColor(color[1],color[2],color[3])
end

function SetBothColors(array, wantedColor)
    array[1] = {}
    array[2] = {}
    for i=1,3 do
        color = wantedColor[i]
        array[1][i] = color
        array[2][i] = color
    end
end

function GetAccessFromNumber(number)
    -- [BRS] - Find the access with the proper access number.
    for key, value in pairs(g_Accesses) do
        if value[1] == number then
            return key, value
        end
    end
end

require("Functions.Monitor.Touch.pressingInRectangle")
require("Functions.Animations.Basic.colorTableLerp")