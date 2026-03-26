-- [BRS] - [[ INFORMATIONS ]] -
-- This contain the definition of all global variables
-- Miscs really. They are defined here rather than letting onTick define them to avoid
-- potential bluescreens in multiplayer... it helps but doesnt fully removes them.

g_scriptsOn      = false -- Received by the manager. If this is false, nothing executes in here.
g_showUI         = false -- Received by the manager. when it switches state, boot animations must happen.
g_previousShowUI = false -- Keeps track of if we're requested or no longer requested

g_vehicleName = property.getText("name")
g_centeredVehicleNameX = c_monitorWidth/2 - ((#g_vehicleName)*c_companyFontFullWidth)/2    -- width/2 - ((nameSize-1) * charwidth) /2

-- This script needs to output this as long as what its showing on the screen matter.
-- Otherwise, it could cut to black for example.
g_UIShown     = false
