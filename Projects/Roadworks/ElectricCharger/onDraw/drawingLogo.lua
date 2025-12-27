screen.setColor(255,255,255)
for index=1, 3 do
    letter = brsLogo[index]

    letter[3](
        letter[c_xIndex],
        letter[c_yIndex][c_animationCurrent],
        4
    )
end