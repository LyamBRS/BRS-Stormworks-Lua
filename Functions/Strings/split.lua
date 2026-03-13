-- [BRS] - [[ Information ]] --
-- `26/03/13`
-- ### Description
-- Split a string into an array of strings everytime a specific other string is encountered.
-- The character / string to split with is not included in returned responses.
-- ### Used for
-- String parsing from properties or other applications like BRIO Base64
-- ### @Input
-- ##### - `text` : `string` = text to split at every matches of `k`
-- ##### - `splitter` : `string` = character or string to split at
-- ### @Returns
-- ##### 1. `splitted` : `table`
-- Table consisting of the input text, splitted everytime `splitter` is found in `text`.
-- So for example, `split("A@B", "@") -> {"A", "B"}`
function split(text, splitter)
    results = {}
    for split in text:gmatch("([^"..splitter.."]+)") do
	   results[#results+1] = split
	end
    return results
end