-- @import "Variables.preprocessor_test.g_globalvar.lua"

-- `25/08/03`
-- ### Description
-- Its just a test function that adds 2 numbers together
-- ### Used for
-- Testing the imports of the python preprocessor.
-- ### @Input
-- ##### - `inputA` : `number` = number on the left of the addition
-- ##### - `inputB` : `number` = number on the right of the addition
-- ### @Returns
-- ##### 1. `result` : `number` = `inputA` + `inputB`
function someTestFunction(inputA, inputB)
    return inputA + inputB
end