require("Projects.Roadworks.ElectricCharger.functions.background.handleAnimationEnd")
require("Functions.Animations.Framework.quintInOutAnimation")
require("Functions.Animations.Framework.createAnimation")
-- [BRS] - [[Information]]
-- The goal is to create a new animation object
-- Using random ranges
-- And make it immediately reach the target
-- ensures the screen doesn't start all dark and at 0.
function createBackgroundAnimation(min, max)
    animation = createAnimation(0, 0, 0, quintInOutAnimation)
    animation = handleAnimationEnd(animation, min, max)
    animation[c_animationCurrent] = animation[c_animationTarget]
    animation[c_animationTimeLeft] = 0
    return animation
end