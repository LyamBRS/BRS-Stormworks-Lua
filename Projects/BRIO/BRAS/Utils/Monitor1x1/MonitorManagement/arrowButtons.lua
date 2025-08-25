    -- [BRS] - Check if we are at the max of the selectable IDs
    reachedLimitLeft = selectedAccess <= 1
    reachedLimitRight = selectedAccess >= amountOfAccesses

    -- [BRS] - Button press detection
    pressingLeftArrow = PressingInRectangle(0,12,14,11) and not g_onGoing and not reachedLimitLeft
    pressingRightArrow = PressingInRectangle(18,12,14,11) and not g_onGoing and not reachedLimitRight

    -- [BRS] - Managing pressing colors
    leftArrow[1] = arrowNormal
    rightArrow[1] = arrowNormal
    if pressingLeftArrow then SetBothColors(leftArrow, arrowPressed) end
    if pressingRightArrow then SetBothColors(rightArrow, arrowPressed) end

    -- [BRS] - Disabled colors
    leftArrow[1] = (g_onGoing or reachedLimitLeft) and arrowDisabled or leftArrow[1]
    rightArrow[1] = (g_onGoing or reachedLimitRight) and arrowDisabled or rightArrow[1]

    -- [BRS] - Lerping the colors towards the wanted ones.
    ColorTableLerp(leftArrow, .2)
    ColorTableLerp(rightArrow, .2)