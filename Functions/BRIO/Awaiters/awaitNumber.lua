require("Functions.BRIO.Utils.brioResetData")
require("Variables.BRIO.dataHolders.constants.awaitTimerHolderIndex")
require("Variables.BRIO.dataHolders.constants.busInHolderIndex")
require("Variables.BRIO.dataHolders.constants.stageHolderIndex")
-- [BRS] - [[ Information ]] --
-- `25/08/04`
-- ### Description
-- Waits after a specific number. Once it got it, it increases the input stage.
-- ### Used for
-- Awaiting END flags or ACKs. The moment your protocol must await a specific number, use this.
-- ### @Input
-- ##### - `brioData` : `g_BRIO_data` = Passed BRIO data array.
-- ##### - `entries` : `table` = {awaitedNumber, maxWaitTime}
-- Until it sees that number... an await timer is increased. If it busts the max await timer, reset occcurs.
function BrioAwaitNumber(brioData, entries)
    awaiting = entries[1]
    maxAwaitTime = entries[2]

    if brioData[c_BusInIndex] == awaiting then
        -- [BRS] - You received the number you wanted. You're ready to go to the next step.
        brioData[c_StageIndex] = brioData[c_StageIndex] + 1
        -- [BRS] - Ensures future awaits start with a fresh await counter.
        brioData[c_awaitedTimeIndex] = 0
    else
        -- [BRS] - We're not receiving the number we want...
        brioData[c_awaitedTimeIndex] = brioData[c_awaitedTimeIndex] + 1
        if brioData[c_awaitedTimeIndex] > maxAwaitTime then
            -- [BRS] - We busted the maximum we were ready to await that number for. It's not comming.
            -- [BRS] - Needs future error call functions as well as getter resets.
            BrioResetData(brioData)
        end
    end
end