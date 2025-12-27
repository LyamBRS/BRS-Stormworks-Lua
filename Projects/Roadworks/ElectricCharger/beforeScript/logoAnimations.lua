require("Functions.Animations.Framework.createAnimation")
require("Functions.Animations.Framework.elasticOut")
require("Functions.Animations.Framework.lerpAnimation")
require("Functions.Drawing.Logo.brs_b")
require("Functions.Drawing.Logo.brs_r")
require("Functions.Drawing.Logo.brs_s")

brsLogo = {
    {                                                       -- B letter
        13,                                                     -- X
        createAnimation(-20, 0, 0, elasticOutAnimation),          -- Y
        logoB                                                   -- drawing function
    },
    {                                                       -- R letter
        38,                                                     -- X
        createAnimation(-20, 0, 0, elasticOutAnimation),          -- Y
        logoR                                                   -- drawing function
    },
    {                                                       -- S letter
        63,                                                     -- X
        createAnimation(-20, 0, 0, elasticOutAnimation),          -- Y
        logoS                                                   -- drawing function
    },
    createAnimation(0, 0, 0, lerpAnimation),         -- sweep motion to make each letters go down
}