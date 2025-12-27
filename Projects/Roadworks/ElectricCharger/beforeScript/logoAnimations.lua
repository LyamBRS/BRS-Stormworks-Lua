require("Functions.Animations.Framework.createAnimation")
require("Functions.Animations.Framework.elasticOut")
require("Functions.Animations.Framework.lerpAnimation")
require("Functions.Drawing.Logo.brs_b")
require("Functions.Drawing.Logo.brs_r")
require("Functions.Drawing.Logo.brs_s")

brsLogoBX = 13
brsLogoBY = createAnimation(-20, -20, 0, elasticOutAnimation)

brsLogoRX = 38
brsLogoRY = createAnimation(-20, -20, 0, elasticOutAnimation)

brsLogoSX = 63
brsLogoSY = createAnimation(-20, -20, 0, elasticOutAnimation)

brsLogoSweep = createAnimation(0, 0, 0, lerpAnimation)