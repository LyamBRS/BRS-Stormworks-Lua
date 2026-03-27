-- [BRS] - [[ INFORMATIONS ]] -
-- Values of the light settings

-- [BRS] - Light settings
c_lightSettingOff = 0           -- All lights are ofg
c_lightSettingDRL = 1           -- Only DRL
c_lightSettingAutomatic = 2     -- Lights are handled automatically
c_lightSettingLowBeams = 3      -- Low beams
c_lightSettingHighBeams = 4     -- High beams

-- [BRS] - Automatic light settings
c_distanceTunnelDetection = 5.5     -- Distance the top distance sensor needs to read to turn on the low beams. Keep low to avoid hangar.
c_clockNightTime          = 0.68    -- Time where the low beams should turn on
c_clockDayTime            = 0.31    -- Time where the low beams should turn off