-- [BRS] - Animations in their quad tables, allowing shorter management and less characters
g_topColorAnimation = createQuadAnimationTable(0,0,0,0,quadInOutAnimation)
g_botColorAnimation = createQuadAnimationTable(0,0,0,0,quadInOutAnimation)
g_fullColorAnimation = createQuadAnimationTable(0,0,0,0,quadInOutAnimation)
g_positionAnimation = createQuadAnimationTable(0,0,96,32,quadInOutAnimation)

-- [BRS] - Individual animations linked to their associated quad tables
g_topColorAnimationR = g_topColorAnimation[1]
g_topColorAnimationG = g_topColorAnimation[2]
g_topColorAnimationB = g_topColorAnimation[3]
g_topColorAnimationA = g_topColorAnimation[4]

-- [BRS] - Animations for the bottom color of the gradiant.
g_botColorAnimationR = g_botColorAnimation[1]
g_botColorAnimationG = g_botColorAnimation[2]
g_botColorAnimationB = g_botColorAnimation[3]
g_botColorAnimationA = g_botColorAnimation[4]

-- [BRS] - Animations for the static color behind the gradiant
g_fullColorAnimationR = g_fullColorAnimation[1]
g_fullColorAnimationG = g_fullColorAnimation[2]
g_fullColorAnimationB = g_fullColorAnimation[3]
g_fullColorAnimationA = g_fullColorAnimation[4]

-- [BRS] - Animations for the position of the gradiant. To move it out the way when reversing for example.
g_positionAnimationX = g_positionAnimation[1]
g_positionAnimationY = g_positionAnimation[2]
g_positionAnimationW = g_positionAnimation[3]
g_positionAnimationH = g_positionAnimation[4]

-- [BRS] - Puts all the animations under one big table, to allow a for loop to update all of them.
g_animations = {
    g_topColorAnimation,
    g_botColorAnimation,
    g_positionAnimation,
    g_fullColorAnimation
}