-- [BRS] - The booting fade is the black gradiant behind the logo
if g_state == stateBootingUp or g_state == stateBootingDown or g_state==stateOff then
    rounded45DegreeGradient(
        -1,         -- x
        -1,         -- y
        98,         -- width
        66,         -- height
        0,          -- red value at the top
        0,          -- blue value at the top
        0,          -- green value at the top
        bootFadeAlphaTop[c_animationCurrent], -- alpha value at the top
        0,          -- red value at the bottom
        0,          -- blue value at the bottom
        0,          -- green value at the bottom
        bootFadeAlphaBot[c_animationCurrent] -- alpha value at the bottom
    )
end