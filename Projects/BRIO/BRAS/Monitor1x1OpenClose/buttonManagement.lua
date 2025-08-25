    require("Projects.BRIO.BRAS.Utils.Monitor1x1.ButtonManagement.arrowButtons")

    if pressingOpen then wantedStatus = c_brasOpened end
    if pressingClose then wantedStatus = c_brasClosed end
    updateStatus = pressingOpen or pressingClose

    -- [BRS] - Initiating the command transmittion
    if updateStatus and not g_onGoing then
        Reset()

        -- [BRS] - Find the access with the proper access number.
        selectedAccessID = -2
        selectedAccessID, access = GetAccessFromNumber(selectedAccess)
        password = access[2]

        g_masterCommands[-3101][2][2][1] = selectedAccessID
        g_masterCommands[-3101][3][2][1] = wantedStatus
        g_masterCommands[-3101][4][2][1] = password
        antennaTransmit = true
        BrioSetMasterCommand(g_BRIOMasterData, g_masterCommands, -3101)
    end