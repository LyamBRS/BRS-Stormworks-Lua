require("Projects.Microprocessors.Dashboard.global.constants.colors.vehicle")

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
c_colorBackgroundGradiantTopPreBootR = c_colorVehicleBodyR
c_colorBackgroundGradiantTopPreBootG = c_colorVehicleBodyG
c_colorBackgroundGradiantTopPreBootB = c_colorVehicleBodyB
c_colorBackgroundGradiantTopPreBootA = 0

c_colorBackgroundGradiantBotPreBootedR = c_colorVehicleBodyR
c_colorBackgroundGradiantBotPreBootedG = c_colorVehicleBodyG
c_colorBackgroundGradiantBotPreBootedB = c_colorVehicleBodyB
c_colorBackgroundGradiantBotPreBootedA = 255

c_colorBackgroundFullPreBootR = 0
c_colorBackgroundFullPreBootG = 0
c_colorBackgroundFullPreBootB = 0
c_colorBackgroundFullPreBootA = 255