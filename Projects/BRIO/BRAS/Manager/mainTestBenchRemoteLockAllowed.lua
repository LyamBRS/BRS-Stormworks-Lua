-- [BRS] - [[ Information ]] --
-- `25/08/19`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `1`
-- ## What does this do?
-- This tests the capabilities of BRAS managers. Which are essentially what manages the accesses
-- This microcontroller allows remote to lock the doors
-- ## Where is this used?
-- In BRAS testbenches that tests all the functionalities of Managers

-- [BRS] - [[  imports  ]] --
require("Variables.BRIO.constants.channel")
require("Variables.BRIO.dataHolders.constants.busOutHolderIndex")
require("Variables.BRIO.dataHolders.constants.busInHolderIndex")
require("Variables.BRIO.functionReturnsHolder")
require("Variables.BRIO.constants.flags.divider")
require("Variables.BRIO.constants.flags.end")
require("Variables.BRIO.commands.masterCommands")
require("Variables.BRIO.commands.slaveCommands")
require("Variables.BRIO.dataHolders.brioMasterData")
require("Variables.BRIO.dataHolders.brioSlaveData")
require("Functions.BRIO.Managers.masterManager")
require("Functions.BRIO.Managers.slaveManager")
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
antennaTransmit = false
g_onGoing = false
message = ""
error = false

resetTimer = 0

-- [BRS] - The data received in slave commands, stored to be reused in master answer commands.
savedAccessID = 0
savedPassword = ""
savedNewPassword = ""
savedWantedStatus = 0

-- [BRS] - If we transmit at the same tick that the command gets 
-- The the transmit boolean may reach the antenna 1 tick too late.
setCommandNextTick = false

-- [BRS] - Creating the access status table.
require("Projects.BRIO.BRAS.Manager.accessPropertyParser")

-- [BRS] - [[   mains   ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    -- Boolean 31 locks all doors.
    -- All numerical output, except 31, indicate if a door is opened or closed. 1: opened, 2: closed.

    -- [BRS] - Identify that BRIO is going
    g_onGoing = (g_BRIOMasterData[c_CommandsIndex] ~= false) or (g_BRIOSlaveData[c_CommandsIndex] ~= false)
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

    -- [BRS] - Start the master reply to the requesting vehicle.
    if setCommandNextTick ~= false then
        BrioSetMasterCommand(g_BRIOMasterData, g_masterCommands, setCommandNextTick)
        setCommandNextTick = false
    end

    -- [BRS] - [[ BRIO ]] --
    require("Projects.BRIO.BRAS.Manager.brio")

    -- [BRS] - [[ Outputs ]] --
    -- [BRS] - Outputs every door's status on their respective composite channel, as well as if they are locked or not.
    for id, access in pairs(g_Accesses) do
        status = access[3]
        accessNumber = access[1]
        output.setBool(accessNumber, status == c_brasLocked)
        output.setNumber(accessNumber, status)
    end

    output.setBool(31, antennaTransmit)
    output.setNumber(32, g_ticksTaken)
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
function ReceivedStatusChangeRequest()
    stages = g_BRIO_results[-3101]
    savedAccessID = stages[1][2][1]
    savedWantedStatus = stages[2][2][1]
    savedPassword = stages[3][2][1]

    if g_Accesses[savedAccessID] ~= nil then
        -- [BRS] - This manager handles this access ID!
        access = g_Accesses[savedAccessID]
        accessPassword = access[2]
        if accessPassword ~= nil then
            -- [BRS] - That access has a password!
            if accessPassword ~= savedPassword then
                -- [BRS] - But the one provided is wrong... rip.
                StartBRIOReply(-4101, c_brasIncorrectPassword)
            else
                ParseNewStatus(access, savedWantedStatus)
            end
        else
            -- [BRS] - The access has no password, so any works.
            ParseNewStatus(access, savedWantedStatus)
        end
    else
        message = "Access id unsupported"
        error = true
    end
end

function ReceivedPasswordChangeRequest()
    stages = g_BRIO_results[-3102]
    savedAccessID = stages[1][2][1]
    savedPassword = stages[2][2][1]
    savedNewPassword = stages[3][2][1]

    if g_Accesses[savedAccessID] ~= nil then
        -- [BRS] - This manager handles this access ID!
        access = g_Accesses[savedAccessID]
        accessPassword = access[2]
        if accessPassword ~= nil then
            -- [BRS] - That access has a password!
            if accessPassword ~= savedPassword then
                StartBRIOReply(-4102, c_brasIncorrectPassword)
            else
                StartBRIOReply(-4102, c_brasSuccess)
            end
        else
            -- [BRS] - The access has no password.
            -- For safety measures, you can't just add one remotely...
            -- You'd lock out everyone bruh.
            StartBRIOReply(-4102, c_brasUnsupported)
        end
    else
        message = "Access id unsupported"
        error = true
    end
end

function ReceivedStatusRequest()
    stages = g_BRIO_results[-3103]
    savedAccessID = stages[1][2][1]

    if g_Accesses[savedAccessID] ~= nil then
        StartBRIOReply(-4103, g_Accesses[savedAccessID][3])
    else
        message = "Access id unsupported"
        error = true
    end
end

-- [BRS] - Automatically sets a master command to send an answer.
-- Since all -4101, -4102, -4103 are the same.
function StartBRIOReply(address, status)
    -- [BRS] - Put the access data into the BRIO stages
    g_masterCommands[address][2][2][1] = savedAccessID
    g_masterCommands[address][3][2][1] = status
    antennaTransmit = true
    setCommandNextTick = address
end

function ParseNewStatus(access, newStatus)
    -- [BRS] - The password matches! Now we can do stuff
    -- According to the received status.
    number = access[1]
    accessLocked = access[3] == c_brasLocked
    repliedStatus = c_brasUnsupported

    if newStatus == c_brasUnlocked and c_brasLocked then
        -- [BRS] - it gets unlocked
        access[3] = c_brasClosed
        repliedStatus = c_brasUnlocked
        message = "Unlocked access "..number
    elseif newStatus == c_brasLocked and not c_brasLocked then
        -- [BRS] - Locking the access.
        access[3] = c_brasClosed
        repliedStatus = c_brasLocked
        message = "Locked access "..number
    elseif newStatus ~= c_brasUnlocked and c_brasLocked then
        -- [BRS] - You can't do anything to a locked access.
        repliedStatus = c_brasLocked
        message = "Access "..number.." is locked."
        error = true
    elseif newStatus ~= c_brasUnlocked then
        -- [BRS] - The status gets applied properly.
        -- There's no point in wasting code to indicate you're
        -- trying to open a door that's already open and stuff.
        message = "Access "..number.." status: (" .. access[3] .. " -> ".. newStatus..")"
        access[3] = newStatus
        repliedStatus = newStatus
    end
    StartBRIOReply(-4101, repliedStatus)
end

function FinishedReplying()
    antennaTransmit = false
    resetTimer = 300
end

function Reset()
    message = "initiated"
    g_ticksTaken = 0
    antennaTransmit = true
    error = false
    savedAccessID = 0
    savedPassword = ""
    savedNewPassword = ""
    savedWantedStatus = 0
end