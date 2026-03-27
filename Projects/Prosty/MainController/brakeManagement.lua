-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles the wheels brakes using the driver seat inputs and other various data.
-- ## Where is this used?
-- Prosty main.lua

-- Brakes must be fully applied when you're in park. Obviously.
if selectedGear == c_gearPark then
    brakes = 1
else
    -- [BRS] - Needs implementation of vector based tire smoke cancel traction control
    brakes = -seatWS
end