
    for i=1, #elementTexts do
        text = elementTexts[i]

        screen.setColor(text[1], text[2], text[3], text[4])
        drawTextOnSurface(text[5][c_elementSurface], text[6])
    end