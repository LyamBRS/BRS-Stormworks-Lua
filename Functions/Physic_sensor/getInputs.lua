-- [BRS] - [[ Information ]] --
-- `26/03/07`
-- ### Description
-- Fetches ALL the inputs of a physic sensor's composite,
-- granted its using its default input values. It then stores
-- that in a physic sensor object.
-- ### Used for
-- Fetching all the data of a physic sensor.
g_physicSensor = {}
for index=1, 17 do
    g_physicSensor[index] = input.getNumber(index)
end