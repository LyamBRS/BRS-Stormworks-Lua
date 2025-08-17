-- [BRS] - The BRIO portion of onTick of the testbench.
    -- [BRS] - [[ Inputs ]] --
    g_BRIOMasterData[c_BusInIndex] = input.getNumber(c_BrioChannel)

    -- [BRS] - Slave commands. Even tho these are in commands, they output data
    if g_masterCommands == nil then
        g_masterCommands = {
            [-3102] = {
                {BrioSendNumber, {-3102}},
                {BrioSendNumber, {selectedAccessID}},
                {BrioSendText, {oldPassword}},
                {BrioSendNumber, {c_BRIO_divider}},
                {BrioSendText, {newPassword}},
                {BrioSendNumber, {c_BRIO_end}},
                {BrioSendNumber, {0}, StopTransmitting},
                {BrioAwaitNumber, {-4102, 20}, ReceivedAnswer}, -- Address
                {BrioGetNumber, {}}, -- Access ID
                {BrioGetNumber, {}}, -- Answer
                {BrioAwaitNumber, {-10, 1}, HandshakeSuccess}
            }
        }
    end

    -- [BRS] - Managing Slave commands
    BrioMasterManager(g_BRIOMasterData, g_masterCommands)

    -- [BRS] - [[ Outputs ]] --
    output.setNumber(c_BrioChannel, g_BRIOMasterData[c_BusOutIndex])