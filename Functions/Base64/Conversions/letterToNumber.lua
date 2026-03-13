-- [BRS] - [[ Information ]] --
-- `26/03/13`
-- ### Description
-- Transforms a letter into its number equivalent.
-- Legacy BRS scripts will have this function named `FromBase64`
--
-- **This function does not automatically include the g_base64 variable, to let you decide if you want it as string or property text.**
-- ### Used for
-- Decoding base64 property texts or BRIO streams.
-- ### @Input
-- ##### - `letter` : `string` = Character to decode into its number format.
-- ### @Returns
-- ##### 1. `number` : `int`
-- Index of that number on the base64 string. If its not found, then 1 is returned.
function numberFromBase64(letter)
    number = g_base64:find(letter)
    return number==nil and 1 or number
end