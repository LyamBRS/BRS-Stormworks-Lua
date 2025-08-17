-- [BRS] - [[ Information ]] --
-- `25/08/06`
-- ## Generic info:
-- #### MC : `MCU1I1O1W2H-T0KZV4`
-- #### SN : `1`
-- ## What does this do?
-- This is the only script of the NAVSA controller.
-- Its purpose is to be a SLAVE microcontroller, which replies a VIN and grade when a request is detected.
-- It does not check for requests errors and will always reply even if its empty.
-- ## Where is this used?
-- Used in vehicles that supports VIN and NAVSA grading. For basic vehicles that just want to hold a basic VIN and grade.

-- [BRS] - [[  imports  ]] --
require("Variables.BRIO.constants.channel")
require("Variables.BRIO.dataHolders.constants.busOutHolderIndex")
require("Variables.BRIO.dataHolders.constants.busInHolderIndex")
require("Variables.BRIO.functionReturnsHolder")
require("Variables.BRIO.constants.flags.divider")
require("Variables.BRIO.constants.flags.end")
require("Variables.BRIO.commands.slaveCommands")
require("Variables.BRIO.dataHolders.brioSlaveData")
require("Functions.BRIO.Managers.slaveManager")
require("Functions.BRIO.Senders.sendNumber")
require("Functions.BRIO.Senders.sendText")
require("Functions.BRIO.Managers.slaveManager")

-- [BRS] - [[ variables ]] --

-- [BRS] - [[   mains   ]] --

function onTick()
    -- [BRS] - [[ Inputs ]] --
    g_BRIOSlaveData[c_BusInIndex] = input.getNumber(c_BrioChannel)

    -- [BRS] - Slave commands. Even tho these are in commands, they output data
    if g_slaveCommands == nil then
        g_slaveCommands = {
            [-3100] = {
                {BrioSendNumber, {-4100}},
                {BrioSendText, {property.getText("VIN")}},
                {BrioSendNumber, {c_BRIO_divider}},
                {BrioSendText, {property.getText("Grade")}},
                {BrioSendNumber, {c_BRIO_end}},
            }
        }
    end

    -- [BRS] - Managing Slave commands
    BrioSlaveManager(g_BRIOSlaveData, g_slaveCommands)

    -- [BRS] - [[ Outputs ]] --
    output.setNumber(c_BrioChannel, g_BRIOSlaveData[c_BusOutIndex])
end

-- [BRS] - [[   Functions   ]] --