require("Variables.BRIO.constants.textFiller")
require("Variables.BRIO.dataHolders.constants.stageHolderIndex")
require("Variables.BRIO.dataHolders.constants.busOutHolderIndex")
require("Variables.BRIO.dataHolders.constants.stepHolderIndex")
-- [BRS] - [[ Information ]] --
-- `25/08/05`
-- ### Description
-- Sends a set string, by shots of 4 characters per ticks.
-- ### Used for
-- Sending text to another microcontroller through the BRIO protocol.
-- ### @Input
-- ##### - `brioData` : `g_BRIO_data` = Passed BRIO data array.
-- ##### - `entries` : `table` = {string}
-- Does not reduce in size in the function or outside of it.
-- The BRIO step is used to navigate through it until it reaches the end.
function BrioSendText(brioData, entries)
    toSend = entries[1]
    -- [BRS] - tells us which group of 4 characters we're currently at on the sending.
    step = brioData[c_StepIndex]
    -- [BRS] - Gets the set of characters to send, based on the cursor provided by the step.
    characters = string.sub(toSend, step+1, step+4)

    -- [BRS] - Populate the characters so the amount to send is always 4.
    while #characters < 4 do
        characters = characters .. c_BRIO_char_filler
    end

    -- [BRS] - Packing for transmission
    brioData[c_BusOutIndex] = string.unpack("f", characters)
    -- [BRS] - Increasing the steps by 4 for the next tick. So we can get the next 4 characters to read.
    brioData[c_StepIndex] = brioData[c_StepIndex] + 4

    -- [BRS] - Checking if you reached the end of the string.
    if brioData[c_StepIndex] > #toSend then
        -- [BRS] - Go to the next stage and resets the steps.
        brioData[c_StageIndex] = brioData[c_StageIndex] + 1
        brioData[c_StepIndex] = 0
    end
end