
g_globalvar = 0
function someTestFunction(inputA, inputB)
    return inputA + inputB
end
bruh = 0
yoMama = true
g_globalvar = 12

G = screen.setColor()

--[[
    This should still be here
]]
function onTick()
    yoMama = input.getBool(1)
    bruh = input.getNumber(2)

    result = someTestFunction(bruh, g_globalvar)
    result = remove1(result)

    output.setNumber(1, result)
end

function onDraw()

end

function remove1(fromThis)
    return fromThis - 1
end