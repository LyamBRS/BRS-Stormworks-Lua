require("Variables.BRIO.dataHolder")

-- [BRS] - [[ Information ]] --
-- `25/08/04`
-- ### Description
-- Resets all of g_BRIO_data's cells that are related to the inputs portion of things.
-- ### Used for
-- Reseting BRIO to be ready for the next input addresses.
-- ### @Input
-- ##### - `brioData` : `g_BRIO_data` = Passed BRIO data array.
function BrioResetInputData(brioData)
    -- [BRS] - Resets the stage back to 0.
    brioData[4] = 0
    -- [BRS] - Resets the steps
    brioData[5] = 0
    -- [BRS] - Removes the executed block from the input. Freeing BRIO to read another address.
    brioData[6] = false
    -- [BRS] - Ensure the counter that checks how long you're waiting for something is at 0.
    brioData[7] = 0
    -- [BRS] - Ensure that the seen BRIO input is 0 for any other logic that'll get executed after this reset.
    brioData[8] = 0
end