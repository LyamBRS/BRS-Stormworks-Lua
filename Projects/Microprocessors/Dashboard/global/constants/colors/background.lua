-- require("Projects.Microprocessors.Dashboard.global.constants.colors.vehicle")

-- [BRS] - [[ Background colors ]] -
-- Uncorrected, global background colors.

-- [BRS] - Gradiant when the dashboard is fully booted, showing speed and stuff.
c_colorBackgroundGradiantTopBootedR = 62
c_colorBackgroundGradiantTopBootedG = 54
c_colorBackgroundGradiantTopBootedB = 41
c_colorBackgroundGradiantTopBootedA = 255

c_colorBackgroundGradiantBotBootedR = 62
c_colorBackgroundGradiantBotBootedG = 54
c_colorBackgroundGradiantBotBootedB = 41
c_colorBackgroundGradiantBotBootedA = 0

-- Stormworks cant do decimal colors. So, if you're not making a gradiant
-- that takes more pixels to show than the drawing surface (45 -> 40 over 10 pixels means the color changes every 2 pixels)
-- its recommended to use this to trick it into doing a proper one, by grading the opacity only.
c_colorBackgroundFullBootedR = 25
c_colorBackgroundFullBootedG = 25
c_colorBackgroundFullBootedB = 25
c_colorBackgroundFullBootedA = 255

-- [BRS] - Gradiant when the dashboard isnt on, but prebooted, that means like showing vehicle name, charge, etc
c_colorBackgroundGradiantTopPreBootR = 166
c_colorBackgroundGradiantTopPreBootG = 129
c_colorBackgroundGradiantTopPreBootB = 18
c_colorBackgroundGradiantTopPreBootA = 0

c_colorBackgroundGradiantBotPreBootedR = 166
c_colorBackgroundGradiantBotPreBootedG = 129
c_colorBackgroundGradiantBotPreBootedB = 18
c_colorBackgroundGradiantBotPreBootedA = 255

c_colorBackgroundFullPreBootR = 62
c_colorBackgroundFullPreBootG = 54
c_colorBackgroundFullPreBootB = 41
c_colorBackgroundFullPreBootA = 255