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

    if pressingOpen then wantedStatus = c_brasOpened end
    if pressingClose then wantedStatus = c_brasClosed end
    updateStatus = pressingOpen or pressingClose

    -- [BRS] - Initiating the command transmittion
    if updateStatus and not g_onGoing then
        Reset()

        -- [BRS] - Find the access with the proper access number.
        password = ""
        selectedAccessID = -2
        for key, value in pairs(g_Accesses) do
            if value[1] == selectedAccess then
                password = value[2]
                selectedAccessID = key
            end
        end

        g_masterCommands[-3101][2][2][1] = selectedAccessID
        g_masterCommands[-3101][3][2][1] = wantedStatus
        g_masterCommands[-3101][4][2][1] = password
        antennaTransmit = true
        BrioSetMasterCommand(g_BRIOMasterData, g_masterCommands, -3101)
    end