    SetColor(text)

    -- [BRS] - Messages are only shown when there's no ongoing communications.
    if not g_onGoing then
        screen.drawTextBox(1,5,30,11,message,0,0)
    else
        screen.drawTextBox(1,5,30,11,loadingAnimationTexts[loadingDotsAnimation],0,0)
    end