-- [BRS] - [[ Information ]] --
-- `25/08/19`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `1`
-- ## What does this do?
-- This allows you to test the functionality of changing the status.
-- ## Where is this used?
-- In BRAS testbench or other moments where I feel silly and want to change the status of a known BRAS access.

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
message = ""
error = false

resetTimer = 0
wantedStatus = c_brasOpened

currentAccessID = 0
selectedAccessID = 0
receivedAnswer = false
handshakeAnswer = 0
receivedAccessID = 0

-- [BRS] - [[   mains   ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    currentAccessID = input.getNumber(1)
    updateStatus = input.getBool(1)

    wantsToOpen = input.getBool(2)
    wantsToClose = input.getBool(3)
    wantsToLock = input.getBool(4)
    wantsToUnlock = input.getBool(5)

    -- [BRS] - Changing the wanted status to send.
    wantedStatus = wantsToOpen and c_brasOpened or wantedStatus
    wantedStatus = wantsToClose and c_brasClosed or wantedStatus
    wantedStatus = wantsToLock and c_brasLocked or wantedStatus
    wantedStatus = wantsToUnlock and c_brasUnlocked or wantedStatus

    -- [BRS] - Identify that BRIO is going
    g_onGoing = g_BRIOMasterData[c_CommandsIndex] ~= false
    if g_onGoing then
        g_ticksTaken = g_ticksTaken + 1
        message = antennaTransmit and "Sending" or "receiving"
    end

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
            message = "No answer"
            error = true
            resetTimer = 300
        end

        if not g_onGoing and not handshakeSuccess then -- Well, it seems like we stopped communicating but not the full thing happened!
            message = "Incomplete handshake"
            error = true
            resetTimer = 300
        end

        if not g_onGoing and handshakeSuccess then -- we received right proper shit mate
            message = "ANS ERR: Unknown"
            message = handshakeAnswer == 0 and "ANS ERR: is 0" or message
            message = handshakeAnswer == c_brasUnsupported and "Operation unsupported" or message
            message = handshakeAnswer == c_brasIncorrectPassword and "Wrong password" or message
            message = handshakeAnswer == c_brasSuccess and "ANS ERR: Success" or message
            message = receivedAccessID ~= selectedAccessID and "Got wrong access ID" or message
            resetTimer = 300

            --[BRS] - Putting handshakeAnswer conditions into variables to reuse the boolean results.
            ansIsLocked = handshakeAnswer == c_brasLocked
            ansIsClosed = handshakeAnswer == c_brasClosed
            ansIsOpened = handshakeAnswer == c_brasOpened
            ansIsUnlocked = handshakeAnswer == c_brasUnlocked

            --[BRS] - Your command failed because the status doesnt match what you should receive.
            message = (ansIsLocked and wantedStatus ~= c_brasLocked) and "Failed. Locked" or message
            message = (ansIsClosed and wantedStatus ~= c_brasClosed) and "ANS ERR: Closed?" or message
            message = (ansIsOpened and wantedStatus ~= c_brasOpened) and "ANS ERR: Opened?" or message
            message = (ansIsUnlocked and wantedStatus ~= c_brasUnlocked) and "ANS ERR: Unlocked?" or message

            message = (ansIsLocked and wantedStatus == c_brasLocked) and "Success: Locked" or message
            message = (ansIsClosed and wantedStatus == c_brasClosed) and "Success: Closed" or message
            message = (ansIsOpened and wantedStatus == c_brasOpened) and "Success: Opened" or message
            message = (ansIsUnlocked and wantedStatus == c_brasUnlocked) and "Success: Unlocked" or message
            
            -- [BRS] - there's an error if Success isn't part of the received answer.
            a, b = string.find(message, "Success")
            error = a == nil
        end
    end

    -- [BRS] - [[ BRIO ]] --
    require("Projects.BRIO.BRAS.StatusChanger.brio")

    -- [BRS] - Initiating the command transmittion
    if updateStatus and not g_onGoing then
        Reset()
        g_masterCommands[-3101][2][2][1] = selectedAccessID
        g_masterCommands[-3101][3][2][1] = wantedStatus
        antennaTransmit = true
        BrioSetMasterCommand(g_BRIOMasterData, g_masterCommands, -3101)
    end

    -- [BRS] - [[ Outputs ]] --
    output.setBool(1, antennaTransmit)
    output.setNumber(1, g_ticksTaken)
end

function onDraw()
    if not g_onGoing then
        if resetTimer > 0 then
            if error then
                screen.setColor(32,0,0)
                screen.drawClear()
                screen.setColor(255,0,0)
            else
                screen.setColor(0,32,0)
                screen.drawClear()
                screen.setColor(0,255,0)
            end
        else
            screen.setColor(8,8,8)
            screen.drawClear()
            screen.setColor(64,64,64)
        end
    else
        screen.setColor(32,32,0)
        screen.drawClear()
        screen.setColor(255,255,0)
    end
    screen.drawTextBox(2,2,92,28, message)

    screen.drawRectF(0,30,(resetTimer/300)*96,2)
end

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
    message = "initiated"
    handshakeAnswer = 0
    g_ticksTaken = 0
    selectedAccessID = currentAccessID
    antennaTransmit = false
    handshakeSuccess = false
    receivedAnswer = false
    receivedAccessID = 0
    error = false
end