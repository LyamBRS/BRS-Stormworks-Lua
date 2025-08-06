require("Variables.BRIO.dataHolders.constants.busInHolderIndex")
require("Variables.BRIO.dataHolders.constants.stageHolderIndex")
require("Variables.BRIO.dataHolders.constants.busOutHolderIndex")
-- [BRS] - [[ Information ]] --
-- `25/08/05`
-- ### Description
-- Sends a set number, before going to the next stage.
-- ### Used for
-- Sending acknowledges, dividers, ends, name it.
-- ### @Input
-- ##### - `brioData` : `g_BRIO_data` = Passed BRIO data array.
-- ##### - `entries` : `table` = {the_number_to_send}
function BrioSendNumber(brioData, entries)
    -- [BRS] - Go to the next stage
    brioData[c_StageIndex] = brioData[c_StageIndex] + 1
    brioData[c_BusOutIndex] = entries[1]
end