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
g_circleEndAnimation = createAnimation(0, 0, 0, quintInOutAnimation)
g_circleStartAnimation = createAnimation(0, 0, 0, quintInOutAnimation)