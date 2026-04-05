
-- [BRS] - Automatic light settings
c_distanceTunnelDetection = 7.5    -- Distance the top distance sensor needs to read to turn on the low beams. Keep low to avoid hangar.
c_clockNightTime          = .67    -- Time where the low beams should turn on
c_clockNightTimeHigh      = .71    -- Time where the high beams should be allowed on.
c_clockDayTimeHigh        = .272   -- Time where the high beams should turn off
c_clockDayTime            = .32    -- Time where the low beams should turn off

c_lightAutoHighDetectionFOV      = .15 -- Compared to the front of the car, Whats the lowest angle difference allowed in which there must be no vehicle for automatic high beams to turn on?
c_lightAutoHighDetectionDuration = 60  -- Time in ticks before high beams turn on after not detecting a car anymore.
c_lightAutoHighSpeedDuration     = 40  -- Time in ticks the car has to be moving above the minimum speed for the high beams to turn on
c_lightAutoHighMinSpeed          = 8.8 -- Minimum speed for the automatic highbeam to activate. (32kmh as per accordance to US law)
c_lightAutoHighMaxFog            = .18 -- Maximum fog allowed before high beams turn off
c_lightAutoHighMaxRain           = .15  -- Maximum rain allowed before high beams turn off

c_lightAutoLowMinFog             = .4 -- Minimum fog for low beams to turn on, so you're more visible
c_lightAutoLowMinRain            = .3 -- Minimum rain for low beams to turn on