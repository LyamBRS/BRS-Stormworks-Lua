require("Functions.Animations.Functions.quintInOutAnimation")
require("Functions.Animations.Framework.createAnimation")
-- [BRS] - [[Information]]
-- The goal is to create a new animation object
-- Using random ranges
-- And make it immediately reach the target
-- ensures the screen doesn't start all dark and at 0.
function createBackgroundAnimation(min, max)
    start = math.random(min, max)
    return createAnimation(
        start,
        start,
        0,
        quintInOutAnimation
    )
end