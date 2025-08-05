require("Variables.BRIO.flags.divider")
require("Variables.BRIO.textFiller")

-- [BRS] - [[ Information ]] --
-- `25/08/04`
-- ### Description
-- Sends a set string, by shots of 4 characters per ticks.
-- ### Used for
-- Sending text to another microcontroller through the BRIO protocol.
-- ### @Input
-- ##### - `brioData` : `g_BRIO_data` = Passed BRIO data array.
-- ##### - `toSend` : `string`
-- Does not reduce in size in the function or outside of it.
-- The BRIO step is used to navigate through it until it reaches the end.
function BrioSendText(brioData, toSend)
    -- [BRS] - tells us which group of 4 characters we're currently at on the sending.
    step = brioData[2]
    -- [BRS] - Gets the set of characters to send, based on the cursor provided by the step.
    characters = string.sub(toSend, step+1, step+4)

    -- [BRS] - Populate the characters so the amount to send is always 4.
    while #characters < 4 do
        characters = characters .. g_BRIO_char_filler
    end

    -- [BRS] - Packing for transmission
    brioData[9] = string.unpack("f", characters)
    -- [BRS] - Increasing the steps by 4 for the next tick. So we can get the next 4 characters to read.
    brioData[2] = brioData[2] + 4

    -- [BRS] - Checking if you reached the end of the string.
    if brioData[2] > #toSend then
        -- [BRS] - Go to the next stage and resets the steps.
        brioData[1] = brioData[1] + 1
        brioData[2] = 0
    end
end