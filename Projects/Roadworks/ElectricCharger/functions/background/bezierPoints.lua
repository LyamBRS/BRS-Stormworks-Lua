require("Projects.Roadworks.ElectricCharger.functions.background.lerpCoordinate")

-- [BRS] - Asked ChatGPT to make me a bezier implementation in Lua.
-- this is one of the function.
-- Evaluate a Bezier curve at t using De Casteljau's algorithm
-- points = { {x,y}, {x,y}, ... }
-- t in [0,1]
function bezierPoint(segments, t)
    temp = {}

    -- Copy points
    for i = 1, #segments do
        temp[i] = {
        	segments[i][c_segmentCurrentPos][c_xIndex],
        	segments[i][c_segmentCurrentPos][c_yIndex]
        }
    end

    -- Reduce until one point remains
    n = #temp
    while n > 1 do
        for i = 1, n - 1 do
            temp[i] = lerpCoordinate(temp[i], temp[i + 1], t)
        end
        n = n - 1
    end

    return temp[1]
end