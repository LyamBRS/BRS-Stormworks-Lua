require("Functions.Animations.Functions.quintInOutAnimation")
require("Functions.Base64.Animated.newAnimatedBase64UnicolorImage")

-- [BRS] - Speed unit elements
g_speedUnitLetter1 = newAnimatedBase64UnicolorImage(
    41, 64, 1,
    49, 47, 44, 0,
    "sul1",
    quintInOutAnimation
)

g_speedUnitLetter2 = newAnimatedBase64UnicolorImage(
    46, 64, 1,
    49, 47, 44, 0,
    "sul2",
    quintInOutAnimation
)

g_speedUnitLetter3 = newAnimatedBase64UnicolorImage(
    51, 64, 1,
    49, 47, 44, 0,
    "sul3",
    quintInOutAnimation
)

-- [BRS] - Speed circle animations
g_circleOpacity = createAnimation(0, 0, 0, quintInOutAnimation)
g_circleEndAnimation = createAnimation(c_circleEndHidden, c_circleEndHidden, 0, quintInOutAnimation)
g_circleStartAnimation = createAnimation(c_circleStartHidden, c_circleStartHidden, 0, quintInOutAnimation)

-- [BRS] - Vehicle name
g_vehicleName = property.getText("name")
x = 96/2 - ((#g_vehicleName-1)*6)/2
g_vehicleNameElements = {}
pos=0
for char in g_vehicleName:gmatch(".") do
    g_vehicleNameElements[#g_vehicleNameElements+1] = newAnimatedBase64UnicolorImage(
        x + pos*6,32,1,
        242,188,27,0,
        "brs"..char,
        quintInOutAnimation
    )
    pos = pos + 1
end
g_vehicleNameWidth = #g_vehicleNameElements * 5 - 1

-- [BRS] - background gradiant
g_backgroundR = createAnimation(0,0,0,quintInOutAnimation)
g_backgroundG = createAnimation(0,0,0,quintInOutAnimation)
g_backgroundB = createAnimation(0,0,0,quintInOutAnimation)
g_backgroundTop = createAnimation(0,0,0,quintInOutAnimation)
g_backgroundBot = createAnimation(0,0,0,quintInOutAnimation)

g_uiSwitch = createAnimation(0,0,0,lerpAnimation)