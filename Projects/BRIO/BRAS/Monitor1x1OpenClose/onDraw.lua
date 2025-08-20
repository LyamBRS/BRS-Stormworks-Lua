function onDraw()
    --------------------------------
    -- [BRS] - Background elements
    --------------------------------
    SetColor(background)
    screen.drawClear()

    -- [BRS] - Cards
    SetColor(cards)
    screen.drawRect(0,0,31,3)
    screen.drawRectF(1,17,30,1)
    screen.drawRectF(0,18,32,14)

    --------------------------------
    -- [BRS] - Buttons
    --------------------------------
    -- [BRS] - Left arrow
    SetColor(leftArrow)
    screen.drawRectF(1,20,1,1)
    screen.drawRectF(2,19,1,3)

    -- [BRS] - Right arrow
    SetColor(rightArrow)
    screen.drawRectF(30,20,1,1)
    screen.drawRectF(29,19,1,3)

    -- [BRS] - Open button
    SetColor(openButton)
    screen.drawRectF(2,24,16,1)
    screen.drawRectF(1,25,16,1)
    screen.drawRectF(1,26,15,1)
    screen.drawRectF(1,27,14,1)
    screen.drawRectF(1,28,13,1)
    screen.drawRectF(1,29,12,1)
    screen.drawRectF(2,30,10,1)
    screen.setColor(4,20,6)
    screen.drawText(3,25,"OP")

    -- [BRS] - Close button
    SetColor(closeButton)
    screen.drawRectF(20,24,10,1)
    screen.drawRectF(19,25,12,1)
    screen.drawRectF(18,26,13,1)
    screen.drawRectF(17,27,14,1)
    screen.drawRectF(16,28,15,1)
    screen.drawRectF(15,29,16,1)
    screen.drawRectF(14,30,16,1)
    screen.setColor(20,4,4)
    screen.drawText(20,25,"CL")

    --------------------------------
    -- [BRS] - Messages
    --------------------------------
    -- [BRS] - BRIO messages
    SetColor(text)
    screen.drawTextBox(1,5,30,11,message,0,0)

    -- [BRS] - Selected access ID
    screen.drawTextBox(4,18,25,5,selectedAccess,0,0)

    --------------------------------
    -- [BRS] - Message timer bar
    --------------------------------
    -- [BRS] - The bar
    screen.drawRectF(1,1,(resetTimer/200)*30,2)

    -- if pressingLeftArrow then
    --     screen.setColor(255,255,255,30)
    -- else
    --     screen.setColor(0,255,0,30)
    -- end
end