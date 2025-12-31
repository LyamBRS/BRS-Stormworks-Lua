-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- handles the charging station's RGB status light's global variable
-- when the station is innactive. Being innactive means not actively
-- charging or discharging.
-- ### Used for
-- Sets it as green when no signal from the antenna is detected.
-- Sets it as yellow if a signal is detected from the antenna.
-- Sets it as red if infinite electric is detected.
-- ### @Input
-- None
-- ### @Returns
-- None
function innactiveStation()
    -- [BRS] - Yellow when someone is connected and the station isnt doing anything. green if nothing is connected
    g_stationLight = g_antennaSignalStrength > 0 and {1,1,0} or {0,1,0}
    -- [BRS] - Red if inf electric is on.
    g_stationLight = g_infElectric and {1,0,0} or g_stationLight

    g_monitorState = true
    g_relayCharger = false
    g_relayDischarger = false
end