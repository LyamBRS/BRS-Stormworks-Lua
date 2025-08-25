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
g_ticksTaken = 0

-- [BRS] - The data received in slave commands, stored to be reused in master answer commands.
savedAccessID = 0
savedPassword = ""
savedNewPassword = ""
savedWantedStatus = 0

currentAccess = 1
g_Accesses = {}

-- Stores what the access' instrument panels is telling us. if we should keep it closed, opened, locked, name it.
g_LocalAccessStatus = {}

amountOfAccesses = 1

-- [BRS] - If we transmit at the same tick that the command gets 
-- The the transmit boolean may reach the antenna 1 tick too late.
setCommandNextTick = false

-- [BRS] - [[   mains   ]] --
function onTick()
    -- [BRS] - [[ Inputs ]] --
    -- All numerical output, except 31 and 32, indicate if a door is opened or closed. 1: opened, 2: closed.
    openAllClosed = input.getBool(1)
    closeAllOpened = input.getBool(2)
    lockAllUnlocked = input.getBool(4)
    unlockAllLocked = input.getBool(5)
    keepAllOpened = input.getBool(3) or openAllClosed
    keepAllLocked = input.getBool(6) or lockAllUnlocked

    -- [BRS] - Creating the access status table.
    require("Projects.BRIO.BRAS.Manager.accessPropertyParser")

    -- [BRS] - Identify that BRIO is going
    g_onGoing = (g_BRIOMasterData[c_CommandsIndex] ~= false) or (g_BRIOSlaveData[c_CommandsIndex] ~= false)
    if g_onGoing then
        g_ticksTaken = g_ticksTaken + 1
        -- message = antennaTransmit and "Sending" or "receiving"
    end

    -- [BRS] - Automated message clearing
    require("Projects.BRIO.BRAS.Utils.OnTick.resetTimer")

    -- [BRS] - Start the master reply to the requesting vehicle.
    if setCommandNextTick ~= false then
        g_BRIO_results = {}
        BrioSetMasterCommand(g_BRIOMasterData, g_masterCommands, setCommandNextTick)
        setCommandNextTick = false
    end

    -- [BRS] - [[ BRIO ]] --
    require("Projects.BRIO.BRAS.Manager.brio")

    -- [BRS] - [[ Outputs ]] --
    -- [BRS] - Outputs every door's status on their respective composite channel, as well as if they are locked or not.
    for id, access in pairs(g_Accesses) do
        accessNumber = access[1]
        closeTimer = access[6]
        -- [BRS] - Handle local access status overwrites
        localStatus = input.getNumber(accessNumber)

        -- [BRS] - Change the local status to the master ones if any.
        -- This is a quick hack that allows all localStatus to be overwritten easily.
        localStatus = closeAllOpened and c_brasClosed or localStatus
        localStatus = unlockAllLocked and c_brasUnlocked or localStatus
        localStatus = keepAllOpened and c_brasOpened or localStatus
        localStatus = keepAllLocked and c_brasLocked or localStatus

        -- [BRS] - Handle the automatic closing of accesses that supports it.
        if access[7] > 0 then
            -- [BRS] - decreases until it reaches 0. At 0 the door closes.
            access[7] = access[7] - 1
            if access[7] == 0 then
                -- [BRS] - At 0, the door closes.
                localStatus = c_brasClosed
            end
        end

        g_LocalAccessStatus[accessNumber] = localStatus
        if localStatus ~= 0 then
            -- [BRS] - An overwrite is set and thus this access must follow it.
            if localStatus == c_brasUnlocked then
                access[3] = c_brasClosed
                access[7] = 0
                access[4] = false
            end

            if localStatus == c_brasOpened then
                access[3] = localStatus
                access[7] = closeTimer
                access[4] = false
            end

            if localStatus == c_brasClosed then
                access[3] = localStatus
                access[7] = 0
                access[4] = false
            end

            if localStatus == c_brasLocked then
                access[3] = c_brasClosed
                access[7] = 0
                access[4] = true
            end
        end

        output.setBool(accessNumber, access[4])
        output.setNumber(accessNumber, access[3])
    end

    output.setBool(31, antennaTransmit)
    output.setBool(32, g_BRIOMasterData[c_BusInIndex] ~= 0 or g_BRIOMasterData[c_BusOutIndex] ~= 0)
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
    savedAccessID = stages[1]
    savedWantedStatus = stages[2]
    savedPassword = stages[3]

    if g_Accesses[savedAccessID] ~= nil then
        -- [BRS] - This manager handles this access ID!
        access = g_Accesses[savedAccessID]
        accessPassword = access[2]
        localStatus = g_LocalAccessStatus[access[1]]
        if localStatus ~= 0 then
            message = "Can't. Access locally overwritten"
            error = true
            reply = c_brasUnsupported
            if localStatus == c_brasLocked and (savedWantedStatus == c_brasClosed or savedWantedStatus == c_brasOpened)  then
                reply = c_brasLocked
            end
            StartBRIOReply(-4101, reply)
        else
            if accessPassword ~= nil and accessPassword ~= "" then
                -- [BRS] - That access has a password!
                if accessPassword ~= savedPassword then
                    -- [BRS] - But the one provided is wrong... rip.
                    message = "Incorrect password: "..savedPassword
                    error = true
                    StartBRIOReply(-4101, c_brasIncorrectPassword)
                else
                    ParseNewStatus(access, savedWantedStatus)
                end
            else
                -- [BRS] - The access has no password, so any works.
                ParseNewStatus(access, savedWantedStatus)
            end
        end
    else
        message = "Access id unsupported"
        error = true
    end
end

function ReceivedPasswordChangeRequest()
    stages = g_BRIO_results[-3102]
    savedAccessID = stages[1]
    savedPassword = stages[2]
    savedNewPassword = stages[3]

    if g_Accesses[savedAccessID] ~= nil then
        -- [BRS] - This manager handles this access ID!
        access = g_Accesses[savedAccessID]
        accessPassword = access[2]
        if accessPassword ~= nil and accessPassword ~= "" then
            -- [BRS] - That access has a password!
            if accessPassword ~= savedPassword then
                message = "Incorrect password: "..savedPassword
                error = true
                StartBRIOReply(-4102, c_brasIncorrectPassword)
            else
                message = "Acess "..access[1].." Password changed!"
                access[2] = savedNewPassword
                StartBRIOReply(-4102, c_brasSuccess)
            end
        else
            -- [BRS] - The access has no password.
            -- For safety measures, you can't just add one remotely...
            -- You'd lock out everyone bruh.
            message = "No password doors cant receive passwords"
            error = true
            StartBRIOReply(-4102, c_brasUnsupported)
        end
    else
        message = "Access id unsupported"
        error = true
    end
end

function ReceivedStatusRequest()
    stages = g_BRIO_results[-3103]
    savedAccessID = stages[1]

    if g_Accesses[savedAccessID] ~= nil then
        access = g_Accesses[savedAccessID]
        accessStatus = access[3]
        if access[4] then -- its locked, not closed.
            accessStatus = c_brasLocked
        end
        StartBRIOReply(-4103, accessStatus)
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
    accessLocked = access[4]
    autoCloseTimer = access[6]
    hasAutoClose = autoCloseTimer > 0
    repliedStatus = c_brasUnsupported
    message = "ERR: None"

    if newStatus == c_brasUnlocked and accessLocked then
        -- [BRS] - it gets unlocked
        access[3] = c_brasClosed
        access[7] = 0
        access[4] = false
        repliedStatus = c_brasUnlocked
        message = "Unlocked access "..number
    elseif newStatus == c_brasLocked and not accessLocked then
        -- [BRS] - Locking the access.
        access[3] = c_brasClosed
        access[7] = 0
        access[4] = true
        repliedStatus = c_brasLocked
        message = "Locked access "..number
    elseif newStatus ~= c_brasUnlocked and accessLocked then
        -- [BRS] - You can't do anything to a locked access.
        repliedStatus = c_brasLocked
        message = "Access "..number.." is locked."
        error = true
    elseif newStatus ~= c_brasUnlocked then
        -- [BRS] - The status gets applied properly.
        -- There's no point in wasting code to indicate you're
        -- trying to open a door that's already open and stuff.
        message = "Access "..number.." status: (" .. access[3] .. " -> ".. newStatus..")"

        -- [BRS] - Set the auto close timer so the door automatically closes, if supported.
        -- [BRS] - Everytime you open the door, it gets reset.
        if hasAutoClose then
            access[7] = autoCloseTimer
        end

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
    message = "awaiting"
    g_ticksTaken = 0
    antennaTransmit = false
    error = false
    savedAccessID = 0
    savedPassword = ""
    savedNewPassword = ""
    savedWantedStatus = 0
end