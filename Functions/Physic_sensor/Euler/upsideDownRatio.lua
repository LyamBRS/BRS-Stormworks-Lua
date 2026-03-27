-- [BRS] - [[ Information ]] --
-- `26/03/27`
-- ### Description
-- Analyzes physic sensors' euler rotations to figure out how much upside down your vehicle is.
-- Assuming the physic sensor points upwards, towards the front of the vehicle AND isn't mirrored.
-- ### Used for
-- Upside down alarms, automatic beams tunnel detections, and anything else you can think of.
-- ### @Input
-- ##### - `eulerX` : `float` = radian euler x from physic sensor
-- ##### - `eulerY` : `float` = radian euler y from physic sensor
-- ##### - `eulerZ` : `float` = radian euler z from physic sensor
-- ### @Returns
-- ##### 1. `upwardRatio` : `float`
-- - 0: Upright
-- - 1: Upside down
function upsideDownRatio(eulerX, eulerY, eulerZ)
    -- [BRS] - Angles are applied to a vector pointing upwards.
    -- If you want to check if you're pointing any other directions
    -- just modify these starting values.
    x, y, z = 0, 1, 0

    -- rotate around X (pitch)
    cos, sin = math.cos(eulerX), math.sin(eulerX)
    y, z = y * cos - z * sin, y * sin + z * cos

    -- rotate around Y (yaw)
    cos, sin = math.cos(eulerY), math.sin(eulerY)
    x, z = x * cos + z * sin, -x * sin + z * cos

    -- rotate around Z (roll)
    cos, sin = math.cos(eulerZ), math.sin(eulerZ)
    x, y = x * cos - y * sin, x * sin + y * cos

    -- [BRS] - Converts to 0: Upright, 1: face down
    return (1 - y) * 0.5
end