    -- [BRS] - manages the colors of the background, cards and texts
    if resetTimer > 0 then
        -- [BRS] - Transmission is finished but we gotta display if there's an error or not.
        cards[1] = error and errorCards or successCards
        background[1] = error and errorBackground or successBackground
        text[1] = error and errorText or successText
    else
        -- [BRS] - Displays the loading color only if BRIO is actively communicating.
        cards[1] = g_onGoing and loadingCards or cardsColor
        background[1] = g_onGoing and loadingBackground or backgroundColor
        text[1] = g_onGoing and loadingText or textColor
    end

    -- [BRS] - Lerping towards wanted colors set above
    ColorTableLerp(cards, .2)
    ColorTableLerp(background, .2)
    ColorTableLerp(text, .2)