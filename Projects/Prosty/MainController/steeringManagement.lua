require("Projects.Prosty.MainController.variables")
-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles how the vehicle steers.
-- ## Where is this used?
-- Prosty main.lua
    -- [BRS] - Needs to account for vehicle speeds and do ackerman.
    steeringLeft = Ackermann(seatAD, 11, 9, -1)
    steeringRight = Ackermann(seatAD, 11, 9, 1)