-- [BRS] - [[ Information ]] --
-- `2025/12/28`
-- ### Description
-- Converts RX antenna signal strength to an almost exact electric
-- store value. Not battery charge, electric store.
-- You need `medium` antennas, set 2 blocks appart.
-- Read the one that receives signal, leave the other one on a seperate
-- battery system that always stays at `1` charge.
-- ### Used for
-- Addons can know exactly the electric store when charging a vehicle.
-- This is the only way of knowing it.
-- ### @Input
-- ##### - `antennaSignal` : `number` = 0-1, antenna signal strength
-- ### @Returns
-- ##### 1. `electric store` : `number` = 0-1. Lowest is 0.00383 
function mediumSignalStrengthToElectricStore(antennaSignal)
    return .000374997 * ((1-antennaSignal)^-1) + .000008
end