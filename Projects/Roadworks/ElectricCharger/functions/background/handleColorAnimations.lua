require("Projects.Roadworks.ElectricCharger.functions.background.handleAnimationEnd")
require("Functions.Animations.Framework.animate")
-- [BRS] - [[ Information ]] --
-- `2025/12/26`
-- ### Description
-- Handles a complete color object from a curve object.
-- ### Used for
-- avoiding duplicate handling of both color objects of a curve object.
-- ### @Input
-- ##### - `color`  : `table`  = 4 indexes. r,g,b,a
function handleColorAnimations(color)
	for index=1, 4, 1 do
		animation = color[index]
		range = colorRanges[index]

    	if animation[c_animationTimeLeft] == 0 then -- we need a new y goal.
    		color[index] = handleAnimationEnd(animation, range[1], range[2])
    	end
    	animate(animation)
	end
end
