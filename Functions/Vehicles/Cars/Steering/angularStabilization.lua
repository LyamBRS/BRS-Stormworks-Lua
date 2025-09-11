-- [BRS] - [[ Information ]] --
-- `25/09/10`
-- ### Description
-- Math function taken from ZE steering controller that stabelizes steering controls based on angular speed.
-- It also takes into consideration the maximum the wheels are allowed to turn as well as the vehicle's direction.
-- Contrary to ZE's math function, this one does **not** compute linearity. Do that in another math function. This is to avoid using lerps.
-- ### Used for
-- Stabelizing the angular momentum of a vehicle based on wanted steering, maximum wheel turn and more.
-- Ensure the vehicle wants to go straight and not loose control in turns.
-- ### @Input
-- ##### - `steeringInput` : `float`
-- Value from -1 to 1 that corresponds to the seat's or systems wanted steering output.
-- ##### - `angularSpeed` : `float`
-- Value representing the angular speed of the vehicle. Taken from a physic sensor or angular speed sensor
-- ##### - `steeringRange` : `float`
-- Value from 0 to 1, that limits how much the wheel can steer. Usually calculated from the dynamic steering adjustment based on speed.
-- ##### - `stabilization` : `float`
-- The sensitivity of stabilization. If you don't want any... don't call this function. Value ranges between >0 to 10.
-- ##### - `reverse` : `bool` : `true` if reversing, `false` if driving forwards.
-- ### @Returns
-- ##### 1. `Stabelized` : `float`
-- Value ranging from `-steeringRange` to `steeringRange` based on angular velocity, driving direction and current steering input.
-- That value can be directly given to wheels or pass through ackermann formulas.
function AngularStabilization(steeringInput, angularSpeed, steeringRange, stabilization, reverse)
    -- [BRS] - Converts raw -1 to 1 steering to its wanted range.
    rangedSteering = steeringInput * steeringRange

    -- [BRS] - Used to flip the angular velocity if we're reversing so wheels turn the right way
    direction = reverse and -1 or 1

    -- [BRS] - Modified ZE stabilization math formula. It's described outside the scope of this function.
    -- If you need help, test it in Desmos.
    -- max and min are direct use of the clamp function without its definition, as its more character efficient this way.
    return math.max(
        math.min(
            -- [BRS] - Interior of the clamp below this line
            rangedSteering +
            4 * stabilization *
            math.abs(angularSpeed) * (
                rangedSteering * .8 -
                direction * angularSpeed
            ),
            -- [BRS] - Clamp values below this line.
            steeringRange
        ),
        -steeringRange
    )
end

-- [BRS] - Copy pasted ZE steering stabilization math functions, decorticated a little bit but not too much...
-- Couldn't be asked really.
-- x = seat
-- y = Non - Linearity (0 - 1)
-- z = Angular speed
-- w = Sensitivity
-- a = Maximum steering range.
-- b = Driving direction. -1 = reverse, 1 = forwards. 
-- clamp(
--     -- Get a value between steering and a cubic lesser value based on non-linearity. 
--     -- 1 = will take a fully exponential function x^3, 0 = the seat direct input.
--     -- The seat has an x^3 curve if not 100% sensitive. So if non-linearity is 1, then its actually completely linear.
--     lerp(x,x^3,y)*
--     a+
--     4*
--     w*
--     abs(z)*(
--         lerp(x,x^3,y)*
--         a*
--         0.8-
--         b*
--         z -- invert the angular speed based on driving direction
--     ),
--     -a, -- clamps the result of the correction between the reduced steering at speeds.
--     a
-- )