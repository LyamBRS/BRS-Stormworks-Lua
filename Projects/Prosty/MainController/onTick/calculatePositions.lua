-- [BRS] - [[ INFORMATIONS ]] - 
-- This part of onTick's job is to convert euler rotations or other physic sensors values
-- into easy to use values for the rest of the script.

-- [BRS] - How upside down are we? from any sides tilt / pitch
g_upsideDownRatio = upsideDownRatio(g_EulerX, g_EulerY, g_EulerZ)