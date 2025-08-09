-- [BRS] - The BRIO portion of onTick of the testbench.
    -- [BRS] - [[ Inputs ]] --
    g_BRIOMasterData[c_BusInIndex] = input.getNumber(32)

    -- [BRS] - Slave commands. Even tho these are in commands, they output data
    if g_masterCommands == nil then
        g_masterCommands = {
            [-3100] = {
                {BrioSendNumber, {-3100}},
                {BrioAwaitNumber, {-4100, 15}, GotAnAnswer},
                {BrioGetText, {property.getText("VIN")}, GotTheVin},
                -- No divider awaiting, cuz the GetText stops when it sees one.
                {BrioGetText, {property.getText("Grade")}, GotTheGrade},
                {BrioAwaitNumber, {c_BRIO_end, 1}},
            }
        }
    end

    -- [BRS] - Managing Slave commands
    BrioMasterManager(g_BRIOMasterData, g_masterCommands)

    -- [BRS] - [[ Outputs ]] --
    output.setNumber(32, g_BRIOMasterData[c_BusOutIndex])