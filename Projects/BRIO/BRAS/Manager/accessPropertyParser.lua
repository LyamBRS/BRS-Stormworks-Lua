-- [BRS] - Access property parser.
-- Populates a table with all the accesses data stored in property values.
-- Starts at "Access1.id" and "Access1.password".
-- Not having a password will make it so any password is valid to change the status of the access.
-- To not have a password, keep the property text "AccessX.password" of the same door number, empty.
-- If you're missing an access number, it will stop parsing property texts and numbers.

g_Accesses = {}
currentAccess = 1
while(currentAccess) do
    accessAsString = tostring(currentAccess)
    accessProperty = "Access" .. accessAsString

    id = property.getNumber(accessProperty .. ".id")
    if id == nil then
        -- [BRS] - There's no more accesses.
        currentAccess = false
    else
        password = property.getText(accessProperty .. ".password")
        -- [BRS] - Initialized to [id] = {door number, access password, closed}
        g_Accesses[id] = {currentAccess, password, c_brasClosed}
    end
end