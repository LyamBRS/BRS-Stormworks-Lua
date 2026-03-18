require("Functions.Animations.Functions.quintInOutAnimation")
require("Functions.Base64.Animated.newAnimatedBase64UnicolorImage")
require("Projects.Microprocessors.Dashboard.global.constants.positions.speedUnit")

-- [BRS] - Easy management of animation to tell the manager we're done or not.
g_uiShownAnimation = createAnimation(0,0,0,lerpAnimation)

-- [BRS] - Speed unit elements
g_speedUnitLetter1 = newAnimatedBase64UnicolorImage(
    c_letter1X, 64, 1,
    49, 47, 44, 0,
    "sul1",
    quintInOutAnimation
)

g_speedUnitLetter2 = newAnimatedBase64UnicolorImage(
    c_letter2X, 64, 1,
    49, 47, 44, 0,
    "sul2",
    quintInOutAnimation
)

g_speedUnitLetter3 = newAnimatedBase64UnicolorImage(
    c_letter3X, 64, 1,
    49, 47, 44, 0,
    "sul3",
    quintInOutAnimation
)

g_speedUnitLetter1Color = g_speedUnitLetter1[c_elementColors][1]
g_speedUnitLetter2Color = g_speedUnitLetter2[c_elementColors][1]
g_speedUnitLetter3Color = g_speedUnitLetter3[c_elementColors][1]
g_speedUnitLetter1Positions = g_speedUnitLetter1[c_elementSurface]
g_speedUnitLetter2Positions = g_speedUnitLetter2[c_elementSurface]
g_speedUnitLetter3Positions = g_speedUnitLetter3[c_elementSurface]

-- [BRS] - Blinkers
g_leftBlinkerAnimation = createQuadAnimationTable(
    c_colorBrightGreenR,
    c_colorBrightGreenG,
    c_colorBrightGreenB,
    0,
    quintInOutAnimation
)

g_rightBlinkerAnimation = createQuadAnimationTable(
    c_colorBrightGreenR,
    c_colorBrightGreenG,
    c_colorBrightGreenB,
    0,
    quintInOutAnimation
)

-- [BRS] - Speed dial
g_speedDialOuterColorAnimations = createQuadAnimationTable(
    c_colorSpeedDialOffTopR,
    c_colorSpeedDialOffTopG,
    c_colorSpeedDialOffTopB,
    c_colorSpeedDialOffTopA,
    quintInOutAnimation
)
g_speedDialInnerColorAnimations = createQuadAnimationTable(
    c_colorSpeedDialOffBotR,
    c_colorSpeedDialOffBotG,
    c_colorSpeedDialOffBotB,
    c_colorSpeedDialOffBotA,
    quintInOutAnimation
)
g_speedDialRadiansAnimations    = createQuadAnimationTable(c_circleStartHidden,c_circleEndHidden,0,0,quintInOutAnimation)

-- [BRS] - Quad animations
g_quadAnimations = {
    g_speedDialOuterColorAnimations,
    g_speedDialInnerColorAnimations,
    g_speedDialRadiansAnimations,
    g_speedUnitLetter1Color,
    g_speedUnitLetter2Color,
    g_speedUnitLetter3Color,
    g_speedUnitLetter1Positions,
    g_speedUnitLetter2Positions,
    g_speedUnitLetter3Positions,
    g_leftBlinkerAnimation,
    g_rightBlinkerAnimation
}