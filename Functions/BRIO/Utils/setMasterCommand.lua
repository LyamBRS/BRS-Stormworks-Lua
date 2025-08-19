require("Variables.BRIO.dataHolders.constants.commandBlockHolderIndex")
require("Variables.BRIO.dataHolders.constants.executedAddressIndex")
-- [BRS] - [[ Information ]] --
-- `25/08/08`
-- ### Description
-- Used by microcontrollers supporting master commands, to trigger BRIO into starting a command.
-- ### Used for
-- Set a BRIO command to begin outputing and doing its thing.
-- ### @Input
-- ##### - `brioData` : `table` = contains inputs, executed commands, and awaited times.
-- ##### - `command` : `table` = command to execute. Must start with a send of the command's address.
function BrioSetMasterCommand(brioData, commands, address)
    if not brioData[c_CommandsIndex] then
        brioData[c_CommandsIndex] = commands[address]
        brioData[c_executedAddressIndex] = address
    end
end