-- [BRS] - The BRIO portion of onTick of the testbench.
    -- [BRS] - [[ Inputs ]] --
    g_BRIOMasterData[c_BusInIndex] = input.getNumber(c_BrioChannel)
    g_BRIOSlaveData[c_BusInIndex] = input.getNumber(c_BrioChannel)

    -- [BRS] - Master commands. These send and await data.
    if g_masterCommands == nil then
        g_masterCommands = {
            -- [BRS] - Reply to access status change
            [-4101] = {
                {BrioSendNumber, {-4101}},
                {BrioSendNumber, {savedAccessID}},
                {BrioSendNumber, {savedWantedStatus}},
                {BrioSendNumber, {c_BRIO_end}, FinishedReplying},
            },
            -- [BRS] - Reply to password change.
            [-4102] = {
                {BrioSendNumber, {-4102}},
                {BrioSendNumber, {savedAccessID}},
                {BrioSendNumber, {savedWantedStatus}},
                {BrioSendNumber, {c_BRIO_end}, FinishedReplying},
            },
            -- [BRS] - Reply to access status request.
            [-4103] = {
                {BrioSendNumber, {-4102}},
                {BrioSendNumber, {savedAccessID}},
                {BrioSendNumber, {savedWantedStatus}},
                {BrioSendNumber, {c_BRIO_end}, FinishedReplying},
            }
        }
    end

    -- [BRS] - Slave commands. These listens and will trigger the proper master command in accordance to accessID and stuff.
    if g_slaveCommands == nil then
        g_slaveCommands = {
            [-3101] = {
                {BrioGetNumber, {}}, -- Access ID
                {BrioGetNumber, {}}, -- Wanted status
                {BrioGetText, {}, ReceivedStatusChangeRequest}   -- Password
            },
            [-3102] = {
                {BrioGetNumber, {}}, -- Access ID
                {BrioGetText, {}},   -- Old password
                {BrioGetText, {}, ReceivedPasswordChangeRequest},   -- New password
            },
            [-3103] = {
                {BrioGetNumber, {}}, -- Access ID
                {BrioAwaitNumber, {-10, 1}, ReceivedStatusRequest}
            }
        }
    end

    -- [BRS] - Managing Slave commands
    BrioMasterManager(g_BRIOMasterData, g_masterCommands)
    BrioSlaveManager(g_BRIOSlaveData, g_slaveCommands)

    -- [BRS] - [[ Outputs ]] --
    output.setNumber(c_BrioChannel, g_BRIOMasterData[c_BusOutIndex])