
-- x = minimum steering
-- y = maximum steering
-- z = max steering below this speed
-- w = minimum steering past this speed
-- a = linear speed sensor
lerp(  -- Linearly choose a value between minimum steering and maximum steering based on current linear speed.
    y, -- Outputs maximum steering if clamp result is 0. This means the speed is below the threshold where it'll always be max values
    x, -- Output minimum steering if clamp result is 1. This means the speedd is above the threshold where it'll stay minimum value.
    clamp(
        ( -- Gets a 0-1 ratio from the current speed agaisnt the threshold of min and max speeds.
            abs(a)-z -- > 1 if speed is above the maximum steering below this speed, otherwise, speed is below the threshold where max is allowed ( < 1)
        )/
        max(
            w-z, -- The speed range in which linear steering happens. (maximum speed - minimum speed) cuz outside of that threshold, it sticks to minimum or maximum steering.
            1    -- If the 2 speeds are close enough, then there's less than a m/s of threshold, so it might as well be 1
        ),
        0, -- The speed is equal or below the maximum steering speed
        1 -- the speed is equal or above the minimum steering speed.
    )
) -- returns a value between minimum and maximum steering based on the current speed and where it ranges between the minimum and maximum speeds.