require("Variables.BRIO.flags.divider")
require("Variables.BRIO.textFiller")

-- [BRS] - [[ Information ]] --
-- `25/08/04`
-- ### Description
-- Sends a set number, before going to the next stage.
-- ### Used for
-- Sending acknowledges, dividers, ends, name it.
-- ### @Input
-- ##### - `brioData` : `g_BRIO_data` = Passed BRIO data array.
-- ##### - `toSend` : `number` = The number to send.
function BrioSendNumber(brioData, toSend)
    -- [BRS] - Go to the next stage
    brioData[1] = brioData[1] + 1
    brioData[9] = toSend
end