function onDraw()
    --------------------------------
    -- [BRS] - Background elements
    --------------------------------
    require("Projects.BRIO.BRAS.Utils.Monitor1x1.drawing.background")

    -- [BRS] - Cards
    require("Projects.BRIO.BRAS.Utils.Monitor1x1.drawing.cards")

    --------------------------------
    -- [BRS] - Buttons
    --------------------------------
    require("Projects.BRIO.BRAS.Utils.Monitor1x1.drawing.arrowButtons")

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
    require("Projects.BRIO.BRAS.Utils.Monitor1x1.drawing.messages")

    -- [BRS] - Selected access ID
    require("Projects.BRIO.BRAS.Utils.Monitor1x1.drawing.accessID")

    --------------------------------
    -- [BRS] - Message timer bar
    --------------------------------
    -- [BRS] - The bar
    screen.drawRectF(1,1,(resetTimer/200)*30,2)
end