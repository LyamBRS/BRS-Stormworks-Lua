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

    -- [BRS] - Ping button
    SetColor(pingButton)
    screen.drawRectF(2,24,28,7)
    screen.drawRectF(1,25,30,5)
    screen.setColor(4,20,6)
    screen.drawText(7,25,"ping")

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