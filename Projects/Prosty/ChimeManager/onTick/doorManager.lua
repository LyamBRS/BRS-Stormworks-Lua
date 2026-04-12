-- [BRS] - [[ INFORMATIONS ]] -
-- Manages which chimes for the access of the vehicle should play.
-- And when they should do it.
-- Allowing timers to be tracked while music is awaited.
--
-- High door chime should play indefinetely if the hood remains opened while driving.
-- High door chime should stop after a while if its only the doors that are opened.
-- If the speed is low, then the low access chime should play.
-- If its only the trunk thats opened, then its the low that should play.

-- [BRS] - Reset before execution
shouldPlayHighAccessChime = false
shouldPlayLowAccessChime = false

-- [BRS] - Door state detection
anythingOpened = (g_driverPivot ~= c_pivotDriverClosed) or (g_passengerPivot ~= c_pivotPassengerClosed) or (g_trunkPivot ~= c_pivotTrunkClosed) or (g_hoodPivot ~= c_pivotHoodClosed)

-- [BRS] - Speed is below the threshold and we're not in park
if g_gear ~= c_gearPark and anythingOpened then
    if g_velocity < c_openedAccessChimeMinSpeed then
        shouldPlayLowAccessChime = true
    else
        shouldPlayHighAccessChime = true
    end
end

-- [BRS] - Changing gears and opening doors should reset the timer.
if g_openedAccessPreviousGear ~= g_gear then
    g_openedAccessPreviousGear = g_gear
    g_openedAccessHighTimer = c_openedAccessChimeHighPlayTime
    g_openedAccessLowTimer = c_openedAccessChimeLowPlayTime
end

-- [BRS] - Timer management
if shouldPlayHighAccessChime then
    g_openedAccessHighTimer = g_openedAccessHighTimer - 1
    g_playHighAccessChime = g_openedAccessHighTimer > 0
else
    g_playHighAccessChime = false
    g_openedAccessHighTimer = c_openedAccessChimeHighPlayTime
end

if shouldPlayLowAccessChime then
    g_openedAccessLowTimer = g_openedAccessLowTimer - 1
    g_playLowAccessChime = g_openedAccessLowTimer > 0
else
    g_playLowAccessChime = false
    g_openedAccessLowTimer = c_openedAccessChimeLowPlayTime
end