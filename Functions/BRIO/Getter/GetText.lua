require("Variables.BRIO.flags.divider")
require("Variables.BRIO.textFiller")

-- [BRS] - [[ Information ]] --
-- `25/08/04`
-- ### Description
-- Receive text through BRIO channels, by shots of 4 characters per ticks.
-- ### Used for
-- Receiving transmitted ASCII texts by other microcontroller.
-- **WARNING** Getting any other numbers than text while this function is running WILL cause bluescreens.
-- The game has no way to try catch a process, so this function is extremely vulnerable to fuck ups.
-- ### @Input
-- ##### - `brioData` : `g_BRIO_data` = Passed BRIO data array.
-- ##### - `textReceivedSoFar` : `string`
-- Initially starts empty. The function will return the gotten text concatenated to this one.
-- So every ticks, it must be fed to the function so it can continue to append the newest characters.
-- ### @Returns
-- ##### 1. `text` : `string`
-- `textReceivedSoFar` concatenated to the characters that were parsed this very tick.
function BrioGetText(brioData, textReceivedSoFar)
    -- [BRS] - Check what's currently read by the Lua script.
    packedCharacters = brioData[8]
    if packedCharacters == g_BRIO_divider then
        -- [BRS] - A divider was received. The stage must increase.
        brioData[4] = brioData[4] + 1
        return textReceivedSoFar
    end

    -- [BRS] - Set the received text as existent if not.
    if textReceivedSoFar == nil then textReceivedSoFar = "" end

    -- [BRS] - Convert the characters back to a string.
    -- This can't be try catched... If you don't give it a valid packed number... You're crashing it.
    decoded = string.pack("f", packedCharacters)
    -- [BRS] - We can only receive 4 characters. So fillers are used if you needed less... Like you sent a string of 3 letters.
    -- This removes the fillers.
    decoded = string.gsub(decoded, g_BRIO_char_filler, "")
    return textReceivedSoFar..decoded
end