-- [BRS] - [[information]]
-- Sets all the outputs handled by the station's system.
-- This must be done AFTER state execution.
-- This must be done BEFORE animations
-- This must always be executed regardless of the current state.

-- [BRS] - BOOLEAN
output.setBool(3, g_relayCharger)
output.setBool(4, g_relayDischarger)
output.setBool(5, g_monitorState)

-- [BRS] - NUMERICAL
output.setNumber(1, g_stationLight[1])
output.setNumber(2, g_stationLight[2])
output.setNumber(3, g_stationLight[3])