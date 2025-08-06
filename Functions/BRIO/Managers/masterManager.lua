require("Functions.BRIO.Managers.executor")
-- [BRS] - [[ Information ]] --
-- `25/08/05`
-- ### Description
-- Manages the execution of BRIO master output commands.
-- ### Used for
-- being able to successfully perform the master commands requested by the Lua script.
-- ### @Input
-- ##### - `brioData` : `table` = see dataHolders.
-- ##### - `commands` : `table` = see masterCommands.
-- ### @Returns
-- None.
function BrioMasterManager(brioData, commands)
    -- [BRS] - Is there any commands we need to execute? Yes? cool. Otherwise we're done here.
    if brioData[c_CommandsIndex] then
        BrioExecutor(brioData)
    end
end