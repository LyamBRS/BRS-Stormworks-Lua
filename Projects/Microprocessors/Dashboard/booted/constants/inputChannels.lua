-- [BRS] ------------------------------------------------ [[ BOOLEAN ]] -
-- FREE:
-- 1
-- 3
-- 5,6,7
-- 14,15,16
-- 27,28,29,30

c_gbScriptActive = 2    -- This script needs to execute
c_gbBootedOn = 4        -- screen is on, colors must change. Same channel as the manager's outputs.

-- [BRS] - Blindspot
c_gbBlindspotLeft   = 8
c_gbBlindspotRight  = 9

-- [BRS] - Special vehicle controls
c_gbHonking         = 20
c_gbCharging        = 31

-- [BRS] - Emergency management
c_gbSlipping        = 21
c_gbCollision       = 22
c_gbDamaged         = 23
c_gbSosActive       = 26

-- [BRS] - Blinkers
c_gbBlinkerLeft     = 10
c_gbBlinkerRight    = 11
c_gbHazards         = 12

-- [BRS] - Lights
c_gbInteriorLight   = 13
c_gbLowBeams        = 17
c_gbHighBeams       = 18
c_gbAutomaticLights = 19

-- [BRS] - Miscs
c_gbDoorsLocked     = 24
c_gbDoorsOpened     = 25
c_gbUniversalBlink  = 32   -- Tick perfect synchronisation of blinking elements for the entire vehicle.

-- [BRS] ------------------------------------------------ [[ NUMERICAL ]] -
-- FREE
-- (1 to 17 are physic sensors) Some can be overwritten.
-- 23,24
-- 26,27
-- 31,32
c_gnCurrentState = 22    -- Channel used to receive the manager script's current state

-- [BRS] - Lights
c_gnLightSetting    = 21

-- [BRS] - Weather
c_gnTemperature     = 18
c_gnRain            = 19
c_gnHumidity        = 20

-- [BRS] - Controls
c_gnCurrentGear     = 25

-- [BRS] - BRS battery management
c_gnBattery         = 28
c_gnBatteryUsage    = 29
c_gnEstimatedRange  = 30