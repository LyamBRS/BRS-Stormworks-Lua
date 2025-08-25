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
communicationAnimationTicks = 0
loadingDotsAnimation = 1

-- [BRS] - Button data
require("Projects.BRIO.BRAS.Monitor1x1StatusPing.drawingData")

-- [BRS] - [[   mains   ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --

    -- [BRS] - Populate the accesses array from property values.
    require("Projects.BRIO.BRAS.Manager.accessPropertyParser")

    -- [BRS] - Identify that BRIO is going
    g_onGoing = g_BRIOMasterData[c_CommandsIndex] ~= false

    -- [BRS] - Loading dots animation.
    require("Projects.BRIO.BRAS.Utils.Monitor1x1.OnTick.loadingAnimation")

    -- [BRS] - Automated message clearing
    require("Projects.BRIO.BRAS.Utils.OnTick.resetTimer")

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
            
            message = (handshakeAnswer == c_brasLocked) and "Locked" or message
            message = (handshakeAnswer == c_brasClosed) and "Closed" or message
            message = (handshakeAnswer == c_brasOpened) and "Opened" or message
            
            message = receivedAccessID ~= selectedAccessID and "ERR: ID" or message
            -- [BRS] - Puts it red if its not closed or opened, to indicate an error or that its locked.
            if message ~= "Closed" and message ~= "Opened" then
                error = true
            end
        end
    end

    -- [BRS] - [[ BRIO ]] --
    require("Projects.BRIO.BRAS.Monitor1x1StatusPing.brio")
    require("Projects.BRIO.BRAS.Monitor1x1StatusPing.monitorManagement")
    require("Projects.BRIO.BRAS.Monitor1x1StatusPing.buttonManagement")

    -- [BRS] - [[ Outputs ]] --
    output.setBool(1, antennaTransmit)
end

require("Projects.BRIO.BRAS.Monitor1x1StatusPing.onDraw")

-- [BRS] - [[   Functions   ]] --
-- Called when the whole password update exchange successfully occured.
-- This doesn't mean that the password changed, but that the handshake was right!
function HandshakeSuccess()
    handshakeSuccess = true
    receivedAccessID = g_BRIO_results[-3103][6]
    handshakeAnswer = g_BRIO_results[-3103][7]
    g_BRIO_results[-3103] = nil
end

function StopTransmitting()
    antennaTransmit = false
end

function ReceivedAnswer()
    receivedAnswer = true
end

require("Projects.BRIO.BRAS.Utils.Monitor1x1.Functions.reset")
require("Projects.BRIO.BRAS.Utils.Monitor1x1.Functions.setColor")
require("Projects.BRIO.BRAS.Utils.Monitor1x1.Functions.setBothColors")
require("Projects.BRIO.BRAS.Utils.Monitor1x1.Functions.getAccessFromNumber")

require("Functions.Monitor.Touch.pressingInRectangle")
require("Functions.Animations.Basic.colorTableLerp")