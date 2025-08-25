-- [BRS] - The BRIO portion of onTick of the testbench.
    -- [BRS] - [[ Inputs ]] --
    g_BRIOMasterData[c_BusInIndex] = input.getNumber(c_BrioChannel)

    -- [BRS] - Master commands. These send and await data.
    if g_masterCommands == nil then
        g_masterCommands = {
            [-3103] = {
                {BrioSendNumber, {-3103}},
                {BrioSendNumber, {selectedAccessID}},
                {BrioSendNumber, {c_BRIO_end}},
                {BrioSendNumber, {0}, StopTransmitting},
                {BrioAwaitNumber, {-4103, 10}, ReceivedAnswer}, -- Address
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