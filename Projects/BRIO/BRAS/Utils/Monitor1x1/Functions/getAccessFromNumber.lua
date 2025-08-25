function GetAccessFromNumber(number)
    -- [BRS] - Find the access with the proper access number.
    for key, value in pairs(g_Accesses) do
        if value[1] == number then
            return key, value
        end
    end
end