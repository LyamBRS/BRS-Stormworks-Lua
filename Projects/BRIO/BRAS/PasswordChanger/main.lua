-- [BRS] - [[ Information ]] --
-- `25/08/16`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `1`
-- ## What does this do?
-- This allows you to test the functionality of changing the password
-- ## Where is this used?
-- In BRAS testbench or other moments where I feel silly and want to change the password of a known BRAS access.

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
oldPassword = property.getText("Old password")
newPassword = property.getText("New password")
antennaTransmit = false
g_onGoing = false
oldOngoing = false
handshakeSuccess = false
message = ""
error = false

receivedAnswer = false
handshakeAnswer = 0

-- [BRS] - [[   mains   ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    selectedAccessID = input.getNumber(1)
    updatePassword = input.getBool(1)

    -- [BRS] - Identify that BRIO is going
    g_onGoing = g_BRIOMasterData[c_CommandsIndex] ~= false
    if g_onGoing then
        g_ticksTaken = g_ticksTaken + 1

        if antennaTransmit then
            message = "Sending"
        else
            message = "receiving"
        end
    end

    if oldOngoing ~= g_onGoing then -- the communication started or stopped.
        oldOngoing = g_onGoing
        if not g_onGoing and not handshakeSuccess then -- Well, it seems like we stopped communicating but not the full thing happened!
            message = "Incomplete handshake"
        end

        if not g_onGoing and not receivedAnswer then -- We never received an answer
            message = "No answer"
        end

        if not g_onGoing and handshakeSuccess then -- we received right proper shit mate
            message = "ANS ERR: Unknown"
            message = handshakeAnswer == c_brasClosed and "ANS ERR: Closed?" or message
            message = handshakeAnswer == c_brasOpened and "ANS ERR: opened?" or message
            message = handshakeAnswer == c_brasUnlocked and "ANS ERR: unlocked?" or message
            message = handshakeAnswer == 0 and "ANS ERR: is 0" or message
            message = handshakeAnswer == c_brasUnsupported and "Operation unsupported" or message
            message = handshakeAnswer == c_brasIncorrectPassword and "Wrong password" or message
            message = handshakeAnswer == c_brasLocked and "Failed. Locked" or message
            message = handshakeAnswer == c_brasSuccess and "Password changed" or message
        end
    end

    -- [BRS] - [[ BRIO ]] --
    require("Projects.BRIO.BRAS.PasswordChanger.brio")

    -- [BRS] - [[ Outputs ]] --
    output.setBool(1, antennaTransmit)
end

function onDraw()

end

-- [BRS] - [[   Functions   ]] --
-- Called when the whole password update exchange successfully occured.
-- This doesn't mean that the password changed, but that the handshake was right!
function HandshakeSuccess()
    handshakeSuccess = true
end

function StopTransmitting()
    antennaTransmit = false
end

function ReceivedAnswer()
    receivedAnswer = true
end