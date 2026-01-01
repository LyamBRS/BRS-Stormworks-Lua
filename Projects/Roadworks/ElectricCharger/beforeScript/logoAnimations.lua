require("Functions.Animations.Framework.createAnimation")
require("Functions.Animations.Functions.elasticOut")
require("Functions.Animations.Functions.lerpAnimation")
require("Functions.Animations.Functions.quintInOutAnimation")
require("Functions.Drawing.Logo.brs_b")
require("Functions.Drawing.Logo.brs_r")
require("Functions.Drawing.Logo.brs_s")

brsLogoBX = 13
brsLogoBY = createAnimation(-31, -31, 0, elasticOutAnimation)

brsLogoRX = 38
brsLogoRY = createAnimation(-31, -31, 0, elasticOutAnimation)

brsLogoSX = 63
brsLogoSY = createAnimation(-31, -31, 0, elasticOutAnimation)

brsLogoSweep = createAnimation(0, 0, 0, lerpAnimation)

-- [BRS] - Boot fade
bootFadeAlphaTop = createAnimation(255, 255, 0, quintInOutAnimation)
bootFadeAlphaBot = createAnimation(255, 255, 0, quintInOutAnimation)

-- [BRS] - booting sounds
g_currentBootSound = 0

-- [BRS] - Small tick delay when we boot on or off to keep the screen black for.
-- Without this, the screen flickers during booting.
-- Why? because the monitor signal takes a few ticks to reach the monitor.
g_monitorDelayCounter = 0