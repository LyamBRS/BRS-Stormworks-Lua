    -- [BRS] - Only need the access to get its name, to draw it.
    _, access = GetAccessFromNumber(selectedAccess)
    accessName = "ERROR"
    if access ~= nil then
        accessName = access[5]
    end
    screen.drawTextBox(4,18,25,5,accessName,0,0)