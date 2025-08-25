function SetBothColors(array, wantedColor)
    array[1] = {}
    array[2] = {}
    for i=1,3 do
        color = wantedColor[i]
        array[1][i] = color
        array[2][i] = color
    end
end