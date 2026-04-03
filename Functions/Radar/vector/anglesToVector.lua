-- require("Functions.Physic_sensor.Euler.toForwardVector")
-- [BRS] - [[ Information ]] --
-- `26/03/29`
-- ### Description
-- Converts physic sensor euler angles to a standard vector.
-- This assumes that the given euler angles are pointing forward of your vehicle
-- ### Used for
-- vector maths with radars, and whatever else I might need this for.
-- ### @Input
-- ##### - `elevation` : `float` = Relative elevation of the target compared to the radar?
-- ##### - `azimuth` : `float`   = With a name like that, i'd never figure out what it is.
-- ### @Returns
-- ##### 1. `vector` : `table`
-- 1: x
-- 2: y
-- 3: z
function radarTargetAnglesToVector(elevation, azimuth)
    -- [BRS] - If I ever do #ifdef directives, this is a perfect implementation moment!
    -- return eulerToForwardVector(elevation, azimuth)
    cosEl = math.cos(elevation)
    return {
        math.sin(azimuth) * cosEl,  -- X (left/right)
        math.sin(elevation),        -- Y (up/down)
        math.cos(azimuth) * cosEl   -- Z (forward)
    }
end