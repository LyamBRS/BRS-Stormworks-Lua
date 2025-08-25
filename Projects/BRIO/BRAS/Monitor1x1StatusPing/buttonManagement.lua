    require("Projects.BRIO.BRAS.Utils.Monitor1x1.ButtonManagement.arrowButtons")

    -- [BRS] - Initiating the command transmittion
    if pressingPing and not g_onGoing then
        Reset()

        -- [BRS] - Find the access with the proper access number.
        selectedAccessID = -2
        selectedAccessID, access = GetAccessFromNumber(selectedAccess)

        g_masterCommands[-3103][2][2][1] = selectedAccessID
        antennaTransmit = true
        BrioSetMasterCommand(g_BRIOMasterData, g_masterCommands, -3103)
    end