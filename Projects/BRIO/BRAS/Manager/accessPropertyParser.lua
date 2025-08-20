-- [BRS] - Access property parser.
-- Populates a table with all the accesses data stored in property values.
-- Starts at "Access1.id" and "Access1.password".
-- Not having a password will make it so any password is valid to change the status of the access.
-- To not have a password, keep the property text "AccessX.password" of the same door number, empty.
-- If you're missing an access number, it will stop parsing property texts and numbers.
if currentAccess then
    accessProperty = "Access" .. currentAccess

    id = property.getNumber(accessProperty .. ".id")
    if id == nil or id == 0 then
        -- [BRS] - There's no more accesses.
        currentAccess = false
    else
        password = property.getText(accessProperty .. ".password")
        -- [BRS] - Initialized to [id] = {door number, access password, closed, locked}
        g_Accesses[id] = {currentAccess, password, c_brasClosed, false}
        currentAccess = currentAccess + 1
        amountOfAccesses = amountOfAccesses + 1
    end
end