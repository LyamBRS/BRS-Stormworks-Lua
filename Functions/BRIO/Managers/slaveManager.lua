require("Variables.BRIO.dataHolders.constants.busInHolderIndex")
require("Variables.BRIO.dataHolders.constants.commandBlockHolderIndex")
require("Variables.BRIO.dataHolders.constants.stageHolderIndex")
require("Variables.BRIO.dataHolders.constants.executedAddressIndex")
require("Variables.BRIO.commands.constants.toExecute")
require("Variables.BRIO.commands.constants.functionEntries")
require("Variables.BRIO.commands.constants.callWhenDone")
require("Variables.BRIO.flags.end")
require("Variables.BRIO.functionReturnsHolder")
require("Functions.BRIO.Managers.executor")
-- [BRS] - [[ Information ]] --
-- `25/08/05`
-- ### Description
-- Manages the execution of BRIO slave output commands.
-- Slave commands listens for their addresses, then gets the data from the command.
-- ### Used for
-- being able to successfully perform the slave commands requested by the Lua script.
-- ### @Input
-- ##### - `brioData` : `table` = see dataHolders.
-- ##### - `commands` : `table` = see masterCommands.
-- ### @Returns
-- None.
function BrioSlaveManager(brioData, commands)
    -- [BRS] - We're not reading any commands... We gotta check if we're reading a valid address.
    if not brioData[c_CommandsIndex] then
        for address, execution in pairs(commands) do
            -- [BRS] - Is the data we're currently reading one of our supported addresses?
            if brioData[c_BusInIndex] == address then
                brioData[c_CommandsIndex] = execution
                -- [BRS] - Do not reset function results pointer array here. Its the job of reader functions to do so when they are done reading them.
            end
        end
    else
        -- [BRS] - We're reading a supported function.
        -- We "waste" characters with an else statement here.
        -- Why? Because we can only enter this 1 tick after we set the function in the statement above.
        -- That means by the time you're here, the first data is ready to be read.
        BrioExecutor(brioData)
    end
end