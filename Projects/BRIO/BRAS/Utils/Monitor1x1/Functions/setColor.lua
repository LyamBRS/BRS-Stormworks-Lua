-- [BRS] - Sets the current color of a target - current color array.
function SetColor(array)
    color = array[2]
    screen.setColor(color[1],color[2],color[3])
end