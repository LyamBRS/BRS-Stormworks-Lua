-- [BRS] - [[information]]
-- Set the charging station's output variables as their default values.
-- By doing so, it also defines them.

-- [BRS] - Controls the monitor's power status.
-- `true` turns on the monitor and consequently execution of onDraw()
-- `false` turns off the monitor and stops onDraw()
g_monitorState = false

-- [BRS] - Controls the charging station's electric detection antenna's relay.
-- `true` will connect it to the station's grid, allowing you to get `electric store` value approximations.
-- `false` will disconnect it from the station's grid.
g_relayAntenna = true

-- [BRS] - Controls the charging station's charger's relay.
-- `true` will connect it to the station's grid, allowing charging of vehicles
-- `false` will disconnect it from the station's grid.
g_relayCharger = true

-- [BRS] - Controls the charging station's discharger's relay.
-- `true` will connect it to the station's grid, allowing discharging of vehicles
-- `false` will disconnect it from the station's grid.
g_relayDischarger = true

-- [BRS] - Controls the charging station's RGB status light.
-- `{0, 0, 0}`
--  - `[1]` -> red (0-1)
--  - `[2]` -> green (0-1)
--  - `[3]` -> blue (0-1)
g_stationLight = {0,0,0}