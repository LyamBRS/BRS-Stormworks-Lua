-- [BRS] - Could be implemented directly in the function that uses it.
-- It would take less character to do so.
function lerpCoordinate(a, b, t)
    return {
        a[c_xIndex] + (b[c_xIndex] - a[c_xIndex]) * t,
        a[c_yIndex] + (b[c_yIndex] - a[c_yIndex]) * t
    }
end