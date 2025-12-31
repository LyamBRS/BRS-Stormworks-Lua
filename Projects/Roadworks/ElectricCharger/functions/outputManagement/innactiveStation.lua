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
    if g_antennaSignalStrength > 0 then 
        -- [BRS] - vehicle is connected. Don't show green. Station taken
        g_stationLight = {1, 1, 0}
    else 
        -- [BRS] - there's no vehicle connected. Station is available.
        g_stationLight = {0, 1, 0}
    end

    if g_infElectric then
        -- [BRS] - Station is unavailable when infinite electric is on.
        g_stationLight = {1, 0, 0}
    end

    g_monitorState = true
    g_relayCharger = false
    g_relayDischarger = false
end