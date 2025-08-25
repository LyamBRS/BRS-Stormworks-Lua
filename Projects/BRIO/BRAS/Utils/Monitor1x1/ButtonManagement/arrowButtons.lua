    -- [BRS] - These both requires that you know how many accesses you support.
    -- Also utilizes old and current to have 1 tick of press time.
    -- [BRS] - Ensure we don't bust the amount of accesses we got.
    if pressingLeftArrow ~= oldLeftArrow then
        oldLeftArrow = pressingLeftArrow
        if selectedAccess > 1 and pressingLeftArrow then
            selectedAccess = selectedAccess - 1
        end
    end

    -- [BRS] - Ensure we don't bust the amount of accesses we got.
    if pressingRightArrow ~= oldRightArrow then
        oldRightArrow = pressingRightArrow
        if selectedAccess < amountOfAccesses and pressingRightArrow then
            selectedAccess = selectedAccess + 1
        end
    end