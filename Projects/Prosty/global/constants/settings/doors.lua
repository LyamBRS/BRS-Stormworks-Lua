-- [BRS] - [[ INFORMATIONS ]] -
-- Values of robotic pivots for their different possible positions.

-- [BRS] ------------------------------------------------ [[ PIVOT POSITIONS ]] -
c_pivotDriverOpened         = -.2
c_pivotDriverClosed         = -1
c_pivotPassengerOpened      = -.2
c_pivotPassengerClosed      = -1
c_pivotTrunkOpened          = .4
c_pivotTrunkClosed          = 0
c_pivotHoodOpened           = .75
c_pivotHoodClosed           = 0

-- [BRS] ------------------------------------------------ [[ CHIME MANAGEMENT ]] -
c_openedAccessChimeMinSpeed         = .3    -- Minimum velocity in m/s the car needs to move at, for the access open chime to play.
c_openedAccessChimeLowPlayTime      = 120   -- The low warning access chime plays for this amount of ticks before shutting up about it. For the trunk or similar.
c_openedAccessChimeHighPlayTime     = 240   -- The high warning access chime plays for this amount of ticks before shutting up about it.