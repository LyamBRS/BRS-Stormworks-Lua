-- [BRS] - [[ Information ]] --
-- `25/08/19`
-- ### Description
-- Lerps a color table with another color table.
-- ### Used for
-- Shortening the calls made to lerp when you're only using it for colors
-- ### @Input
-- ##### - `array` : `table`
-- The current colors as well as wanted colors.
-- {{wantedR, wantedG, wantedB}, {currentR, currentG, currentB}}
-- ##### - `speed` : `float` = Ratio used by the lerp for the speed. 1 = 1 tick. 0.5 = slower. it's arbitrary because this isn't the way lerp really should be used.
function ColorTableLerp(array, speed)
    for i=1,3 do
        current = array[2]
        current[i] = current[i] * (1-speed) + array[1][i] * speed
    end
end