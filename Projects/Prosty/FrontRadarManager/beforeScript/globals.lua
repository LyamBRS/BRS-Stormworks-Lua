-- [BRS] - [[ INFORMATIONS ]] -
-- Declaration of global variables that requires external declaration.
-- Any timers or anything NOT REFRESHED EVERYTICKS must be found here.

-- [BRS] - Must reach 0 before we're sure there's no cars in front anymore.
-- Everytime a new thing is detected in front, it resets back to its constant value.
g_frontDetectionPersistance = 0
g_nothingInFront = false