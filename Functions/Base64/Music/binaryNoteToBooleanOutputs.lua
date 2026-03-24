-- [BRS] - [[ Information ]] --
-- `26/03/24`
-- ### Description
-- Decodes a number from a base64 music and transforms it in a table of true and false for each
-- composite channel related. This function is dynamic and only does as much decoding as the
-- specified amount of supported output.
-- ### Used for
-- Taking a number from a music bundle and obtaining what to output on composite channels.
-- **WARNING**
-- 
-- This function assumes you declared a constant named `c_base64MusicResolution = x`
-- which defines how many boolean composite channels the music needs to be outputed on.
-- ### @Input
-- ##### - `binary` : `int` = binary to convert into a table
-- ### @Returns
-- ##### 1. `result` : `table`
-- The table of true and false, with as many true and falses as `c_base64MusicResolution`
function binaryNoteToBooleanOutputs(binary)
    -- [BRS] - Legacy code below:
    -- r = {}
    -- while binary>0 do
    --     rest = binary%2
    --     table.insert(r,1,rest==1)
    --     binary = (binary-rest)/2
    -- end
    --
    -- for i=#r,23,1 do
    -- 	table.insert(r,1,false)
    -- end
    result = {}
    for i = c_base64MusicResolution, 1, -1 do
        result[i] = (binary & 1) == 1
        binary = binary >> 1
    end
    return result
end