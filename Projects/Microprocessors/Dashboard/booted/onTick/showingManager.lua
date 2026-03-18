-- [BRS] - Reduces the timer until the animation is done.
animate(g_uiShownAnimation)
--  if the manager wants the UI shown, it shows only once it reaches 1. Keeps showing until its not exactly 0.
if g_showUI then
	g_UIShown = g_uiShownAnimation[c_animationCurrent] == 1
else
	g_UIShown = g_uiShownAnimation[c_animationCurrent] > 0
end