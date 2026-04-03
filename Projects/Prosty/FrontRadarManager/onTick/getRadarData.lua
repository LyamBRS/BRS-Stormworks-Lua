-- [BRS] - [[ INFORMATIONS ]] -
-- Gets the radar's currently seen 8 targets.
-- This exclude time since detection, as it's futile when the radar is spinning at the current speed.

for i=1,c_radarMaxTargets*3,3 do
    distance        = input.getNumber(i)   -- meters
    azimuth         = input.getNumber(i+1)
    elevation       = input.getNumber(i+2) -- radians

    if distance>0 and azimuth~=0 and elevation~=0 then
        relativeVector  = radarTargetAnglesToVector(elevation, azimuth)

        g_targets[#g_targets+1] = {
            distance,                   -- c_targetDistance
            azimuth,                    -- c_targetAzimuth
            elevation,                  -- c_targetElevation
            relativeVector,             -- c_targetVector
            c_radarTicksPerRotation,    -- c_targetTimeToLive
        }
    end
end