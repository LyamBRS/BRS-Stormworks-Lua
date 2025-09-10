require("stuff")

-- [BRS] - [[ Information ]] --
-- `25/09/09`
-- ### Description
-- This function performs ackerman steering for one of a vehicle's wheels.
-- It'll perform math calculations based on the vehicle's size and wheel position on the vehicle.
-- ### Used for
-- Ackerman steering simulation for a vehicle's steering.
-- ### @Input
-- ##### - `steering` : `float` = steering value, -1 to 1
-- ##### - `wheelbase` : `int` = Wheel base of the vehicle. One axle to the other, in blocks
-- ##### - `trackwidth` : `int` = Block distance between both wheels on the same axle.
-- ##### - `side`: `int` = 1: Right wheel, -1: Left wheel.
-- ### @Returns
-- ##### 1. `Steering` : `float`: wheel value that the wheel must take.
function Ackermann(steering, wheelbase, trackWidth, side)

    -- Tells the maths you're steering right if you're above 0 or right otherwise.
    steeringDirection = steering > 0 and 1 or -1
    steeringAbsolute = math.abs(steering)

    computed = steeringDirection * math.atan(
        wheelbase * math.tan(
            steeringAbsolute
        ) / (
            wheelbase +
            trackWidth *
            math.tan(steeringAbsolute)
        )
    )

    -- [BRS] depending on the side being steered, we want the minimum or maximum value between the computed and the raw steering.
    if side == 1 then
        -- [BRS] you're steering right, you must then check if x is bigger than the computed one.
        computed = steering > computed and steering or computed
        fuckAssMaths = (1 - side) * steering
    else
        -- [BRS] you're steering left, you must then check if x is less than the computed one.
        computed = steering < computed and steering or computed
        fuckAssMaths = -(1 - side) * steering
    end

    -- [BRS] - idk what the fuck ass math does... or how i would even name this...
    -- [BRS] - That's my issue with math... cool formula bro, why do you do it? no clue! here's "a" and "b" for ur variables.
    return side * computed + fuckAssMaths
end

-- [BRS] - Built from ZE ackerman steering... which is based on any other ackerman steering.
-- y = wheelbase
-- x = steering
-- z = track
-- w = ackerman or not. (1 or 0)
--  w*max(
--      x,
--      sgn(x)*
--          atan(
--              y*
--              tan(
--                  abs(x)
--                  )
--              /(
--                  y+
--                  z*
--                  tan(abs(x))
--               )
--          )
--  )+(1-w)*x -- right
-- -w*min(x,sgn(x)*atan(y*tan(abs(x))/(y+z*tan(abs(x)))))-(1-w)*x -- left