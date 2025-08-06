require("Variables.BRIO.dataHolders.constants.stageHolderIndex")
require("Variables.BRIO.dataHolders.constants.busOutHolderIndex")
require("Variables.BRIO.dataHolders.constants.stepHolderIndex")
require("Variables.BRIO.dataHolders.constants.awaitTimerHolderIndex")
require("Variables.BRIO.dataHolders.constants.commandBlockHolderIndex")
require("Variables.BRIO.dataHolders.constants.executedAddressIndex")
-- [BRS] - [[ Information ]] --
-- `25/08/04`
-- ### Description
-- Resets all of g_BRIO_data's cells that are related to the inputs portion of things.
-- ### Used for
-- Reseting BRIO to be ready for the next input addresses.
-- ### @Input
-- ##### - `brioData` : `g_BRIO_data` = Passed BRIO data array.
function BrioResetData(brioData)
    -- [BRS] - Resets the stage back to 0.
    brioData[c_StageIndex] = 0
    -- [BRS] - Resets the steps
    brioData[c_StepIndex] = 0
    -- [BRS] - Removes the executed block from the input. Freeing BRIO to read another address.
    brioData[c_CommandsIndex] = false
    -- [BRS] - Ensure the counter that checks how long you're waiting for something is at 0.
    brioData[c_awaitedTimeIndex] = 0
    -- [BRS] - Ensure that the seen BRIO input is 0 for any other logic that'll get executed after this reset.
    brioData[c_BusInIndex] = 0
    -- [BRS] - Ensures that anything that was to be outputed doesn't.
    brioData[c_BusOutIndex] = 0
    -- [BRS] - Ensures we're no longer saying that we're executing a specific address.
    brioData[c_executedAddressIndex] = 0
end