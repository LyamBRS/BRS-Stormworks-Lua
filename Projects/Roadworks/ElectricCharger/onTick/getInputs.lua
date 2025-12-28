-- [BRS] - Gather all the composite inputs of this system.
-- [BRS] - BOOLEAN
g_playerSensor = input.getBool(3)
-- [BRS] - NUMERICAL
g_antennaSignalStrength = input.getNumber(7)
g_infElectric = input.getNumber(8) ~= 0

-- [BRS] - Monitor
require("Functions.Monitor.onTickVariableGetting")