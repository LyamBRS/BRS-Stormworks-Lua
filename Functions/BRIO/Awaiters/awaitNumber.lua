require("Variables.BRIO.maxAwait")
require("Functions.BRIO.Utils.brioResetInputData")
-- [BRS] - [[ Information ]] --
-- `25/08/04`
-- ### Description
-- Waits after a specific number. Once it got it, it increases the input stage.
-- ### Used for
-- Awaiting END flags or ACKs. The moment your protocol must await a specific number, use this.
-- ### @Input
-- ##### - `brioData` : `g_BRIO_data` = Passed BRIO data array.
-- ##### - `awaitingThis` : `number`
-- Until it sees that number... an await timer is increased. If it busts the max await timer, reset occcurs.
function BrioAwaitNumber(brioData, awaitingThis)
    if brioData[8] == awaitingThis then
        -- [BRS] - You received the number you wanted. You're ready to go to the next step.
        brioData[4] = brioData[4] + 1
        -- [BRS] - Ensures future awaits start with a fresh await counter.
        brioData[7] = 0
    else
        -- [BRS] - We're not receiving the number we want...
        brioData[7] = brioData[7] + 1
        if brioData[7] > g_BRIO_max_waiting then
            -- [BRS] - We busted the maximum we were ready to await that number for. It's not comming.
            -- [BRS] - Needs future error call functions as well as getter resets.
            BrioResetInputData(brioData)
        end
    end
end