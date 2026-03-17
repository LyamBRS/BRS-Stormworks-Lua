require("Projects.Microprocessors.Dashboard.global.constants.positions.brsFont")
require("Projects.Microprocessors.Dashboard.global.constants.positions.monitor")
require("Functions.Animations.Functions.elasticInOut")
require("Functions.Base64.Animated.newAnimatedBase64UnicolorImage")
-- [BRS] - [[ INFORMATIONS ]] -
-- This file contains the global definitions of all animated elements used in the script.

-- [BRS] - Vehicle name
-- WARNING this assumes you have the right property text values for each letter of the alphabet from which your vehicle
-- name is made of. For example, prosty needs brsp brsr brso brss brst brsy.

-- Start pixel to draw the text centered on the monitor
g_vehicleNameElements = {}
pos=0
for char in g_vehicleName:gmatch(".") do
    g_vehicleNameElements[#g_vehicleNameElements+1] = newAnimatedBase64UnicolorImage(
        g_centeredVehicleNameX + pos*c_companyFontFullWidth,32,1,
        c_colorVehicleNameOffR,
        c_colorVehicleNameOffG,
        c_colorVehicleNameOffB,
        c_colorVehicleNameOffA,
        "brs"..char,
        elasticInOutAnimation
    )
    pos = pos + 1
end
-- g_vehicleNameWidth = #g_vehicleNameElements * c_companyFontWidth - 1