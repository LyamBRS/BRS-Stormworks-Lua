-- [BRS] - [[ Information ]] --
-- `25/08/03`
-- ## Generic info:
-- #### MC : `nil`
-- #### SN : `nil`
-- ## What does this do?
-- This is just a basic lua microcontroller setup to test that the preprocessor
-- removes the right comments and duplicate imports.
-- ## Where is this used?
-- In the tests of the pre-processor.

-- [BRS] - [[  imports  ]] --
-- @import "Functions.preprocessor_test.testFunction.lua"
-- @import "Variables.preprocessor_test.g_globalvar.lua"

-- [BRS] - [[ variables ]] --
bruh = 0
yoMama = true
g_globalvar = 12

-- [BRS] - [[   mains   ]] --
--[[
    This should still be here
]]
function onTick()
    -- [BRS] - [[ Inputs ]] --
    yoMama = input.getBool(1)
    bruh = input.getNumber(2)

    result = someTestFunction(bruh, g_globalvar)
    result = remove1(result)

    -- [BRS] - [[ Outputs ]] --
    output.setNumber(1, result)
end

function onDraw()

end

-- [BRS] - [[   Functions   ]] --
function remove1(fromThis)
    return fromThis - 1
end