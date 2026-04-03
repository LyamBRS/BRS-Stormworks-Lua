-- [BRS] - [[ INFORMATIONS ]] -
-- Constants related to the handling of the radar.

c_radarMaxTargets       = 8                     -- Maximum amount of detected targets by that radar
c_radarSpeed            = 51                    -- Speed set in the radar's properties
c_radarFOVHorizontal    = .25                   -- Horizontal FOV
c_radarFOVVertical      = .25                   -- Vertical FOV
c_radarAngleDelta       = .2480                 -- How much angle is made per tick by the radar spinning
c_radarTicksPerRotation = 1 / c_radarAngleDelta -- How many ticks it takes the radar to make a full rotation