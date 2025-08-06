require("Variables.BRIO.dataHolders.constants.busInHolderIndex")
require("Variables.BRIO.dataHolders.constants.commandBlockHolderIndex")
require("Variables.BRIO.dataHolders.constants.stageHolderIndex")
require("Variables.BRIO.dataHolders.constants.executedAddressIndex")
require("Variables.BRIO.commands.constants.toExecute")
require("Variables.BRIO.commands.constants.functionEntries")
require("Variables.BRIO.commands.constants.callWhenDone")
require("Variables.BRIO.flags.end")
require("Variables.BRIO.functionReturnsHolder")
-- [BRS] - [[ Information ]] --
-- `25/08/05`
-- ### Description
-- Manages the execution of BRIO commands. Works both as the master and the slave executor.
-- ### Used for
-- being able to successfully perform the commands requested by the Lua script.
-- ### @Input
-- ##### - `brioData` : `table` = see dataHolders.
-- ### @Returns
-- None.
function BrioExecutor(brioData)
    busIn = brioData[c_BusInIndex]
    -- [BRS] - Since we begin at stage 0, we must read 1 above the current stage.
    stage = brioData[c_StageIndex] + 1
    -- [BRS] - Get the current stage's command to execute and its data.
    executionData = brioData[c_CommandsIndex][stage]
    executedAddress = brioData[c_executedAddressIndex]

    -- [BRS] - Functions always output in the global result manager. Even if they don't need to.
    if g_BRIO_results[executedAddress] == nil then
        g_BRIO_results[executedAddress] = {}
    end

    -- [BRS] - Executing the function
    g_BRIO_results[executedAddress][stage] = executionData[c_ToExecuteIndex](brioData, executionData[c_EntriesIndex], g_BRIO_results[executedAddress][stage])
    
    -- [BRS] - If the execution successfully ended, then the stage increased. If thats the case, we must check for the callOnSuccess function and do it.
    newStage = brioData[c_StageIndex]
    if newStage > stage and brioData[c_callWhenDoneIndex] ~= nil then
        brioData[c_callWhenDoneIndex]()
    end

    -- [BRS] - Seeing an END, you must reset everything. Same if you're now past the amount of stages of that function.
    if busIn == c_BRIO_end or newStage > #executionData then
        BrioResetData(brioData)
    end
end