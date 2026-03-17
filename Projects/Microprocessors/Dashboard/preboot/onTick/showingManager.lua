-- [BRS] - Reduces the timer until the animation is done.
animate(g_uiShownAnimation)
g_UIShown = (g_uiShownAnimation[c_animationTimeLeft] ~= 0) or g_uiShownAnimation[c_animationCurrent]==1