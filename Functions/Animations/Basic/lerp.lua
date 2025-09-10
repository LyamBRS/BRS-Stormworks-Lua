-- [BRS] - [[ Information ]] --
-- `25/09/10`
-- ### Description
-- The linear interpolation between 2 values.
-- ### Used for
-- Dynamic animations as a quick quad in quad out if used a certain way, OR linearly get from A to B depending on target values, 0 being at A and 1 being at B.
-- Anything in between 0 and 1 is between A and B.
-- ### @Input
-- ##### - `low` : `float`
-- When the target equals 0, the function will output this.
-- If used for animations, this is where you put the current value to "lerp" towards the other.
-- ##### - `high` : `float`
-- When the target equals 1, the function will output this.
-- If used for animations, this is the target you want the current value to reach over several ticks.
-- ##### - `target` : `float` - (0 - 1)
-- Value between 0 and 1. When used normally, this indicate the value (between low and high) you want.
-- So 0 will output low, 1 will output 1 and 0.5 will output the middle point between low and high.
-- If you use this for quick lua animations, then 1 means itll take 1 tick to reach the target, 0 won't ever reach it
-- and the closer you are to 1 the faster itll reach the end goal.
-- ### @Returns
-- ##### 1. `Interpolate` : `float`
-- Value between low and high, target of the way there. See the target variable for more info.
function Lerp(low, high, target)
    return low * (1-target) + high * target
end