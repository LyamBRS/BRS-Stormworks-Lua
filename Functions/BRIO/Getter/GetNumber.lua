require("Functions.BRIO.Utils.brioResetData")
require("Variables.BRIO.dataHolders.constants.awaitTimerHolderIndex")
require("Variables.BRIO.dataHolders.constants.busInHolderIndex")
require("Variables.BRIO.dataHolders.constants.stageHolderIndex")
-- [BRS] - [[ Information ]] --
-- `25/08/16`
-- ### Description
-- Saves the current BRIO number in the results, immediately go to the next stage. No awaiting.
-- ### Used for
-- getting a number, then saving it. From a series of incoming number every tick for example.
-- ### @Input
-- ##### - `brioData` : `g_BRIO_data` = Passed BRIO data array.
-- ##### - `entries` : `table` = {awaitedNumber, maxWaitTime}
-- Until it sees that number... an await timer is increased. If it busts the max await timer, reset occcurs.
function BrioGetNumber(brioData, entries)
    -- [BRS] - You received the number you wanted. You're ready to go to the next step.
    brioData[c_StageIndex] = brioData[c_StageIndex] + 1
    return brioData[c_BusInIndex]
end