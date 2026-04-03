-- [BRS] - [[ Information ]] --
-- `26/03/29`
-- ### Description
-- Converts physic sensor euler angles to a standard vector.
-- This assumes that the given euler angles are pointing forward of your vehicle
-- ### Used for
-- vector maths with radars, and whatever else I might need this for.
-- ### @Input
-- ##### - `eulerX` : `float` = radian euler x from physic sensor
-- ##### - `eulerY` : `float` = radian euler y from physic sensor
-- ### @Returns
-- ##### 1. `vector` : `table`
-- 1: x
-- 2: y
-- 3: z
function eulerToForwardVector(eulerX, eulerY)
    return {
        math.cos(eulerX) * math.cos(eulerY),
        math.cos(eulerX) * math.sin(eulerY),
        math.sin(eulerX)
    }
end