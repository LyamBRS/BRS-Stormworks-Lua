    communicationAnimationTicks = communicationAnimationTicks + 1
    if communicationAnimationTicks>2 then
        loadingDotsAnimation = loadingDotsAnimation + 1
        if loadingDotsAnimation > 6 then
            -- [BRS] - Reset the dots animation. 8 is the size of the loadingAnimationTexts table.
            -- resets to 1 because its a table index.
            loadingDotsAnimation = 1
        end
        communicationAnimationTicks = 0
    end