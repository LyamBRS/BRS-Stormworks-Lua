    -- [BRS] - Monitor touch inputs.
    g_pressing = input.getBool(1)
    g_pressingCoordsX = input.getNumber(3)
    g_pressingCoordsY = input.getNumber(4)

    -- [BRS] - Check if we are at the max of the selectable IDs
    reachedLimitLeft = selectedAccess <= 1
    reachedLimitRight = selectedAccess >= amountOfAccesses

    -- [BRS] - Button press detection
    pressingLeftArrow = PressingInRectangle(0,12,14,11) and not g_onGoing and not reachedLimitLeft
    pressingRightArrow = PressingInRectangle(18,12,14,11) and not g_onGoing and not reachedLimitRight
    pressingOpen = PressingInRectangle(0,24,14,8) and not g_onGoing
    pressingClose = PressingInRectangle(18,24,14,8) and not g_onGoing

    -- [BRS] - Managing pressing colors
    leftArrow[1] = arrowNormal
    rightArrow[1] = arrowNormal
    openButton[1] = openColor
    closeButton[1] = closeColor
    if pressingLeftArrow then SetBothColors(leftArrow, arrowPressed) end
    if pressingRightArrow then SetBothColors(rightArrow, arrowPressed) end
    if pressingOpen then SetBothColors(openButton, openPressedColor) end
    if pressingClose then SetBothColors(closeButton, closePressedColor) end

    -- [BRS] - Disabled colors
    leftArrow[1] = (g_onGoing or reachedLimitLeft) and arrowDisabled or leftArrow[1]
    rightArrow[1] = (g_onGoing or reachedLimitRight) and arrowDisabled or rightArrow[1]
    openButton[1] = g_onGoing and disabledColor or openButton[1]
    closeButton[1] = g_onGoing and disabledColor or closeButton[1]

    -- [BRS] - Text and background colors
    if resetTimer > 0 then
        -- [BRS] - Transmission is finished but we gotta display if there's an error or not.
        cards[1] = error and errorCards or successCards
        background[1] = error and errorBackground or successBackground
        text[1] = error and errorText or successText
    else
        cards[1] = g_onGoing and loadingCards or cardsColor
        background[1] = g_onGoing and loadingBackground or backgroundColor
        text[1] = g_onGoing and loadingText or textColor
    end

    -- [BRS] - Lerping the colors towards the wanted ones.
    ColorTableLerp(leftArrow, .2)
    ColorTableLerp(rightArrow, .2)
    ColorTableLerp(openButton, .2)
    ColorTableLerp(closeButton, .2)
    ColorTableLerp(cards, .2)
    ColorTableLerp(background, .2)
    ColorTableLerp(text, .2)