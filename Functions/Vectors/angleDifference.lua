require("Functions.Vectors.dotProduct")
-- [BRS] - [[ Information ]] --
-- `26/03/29`
-- ### Description
-- Take 2 vectors, dot products them, and tells you the angle difference between the 2.
-- ### Used for
-- Comparing targets with vehicle for example.
-- ### @Input
-- ##### - `vectorA` : `Table` = First vector
-- ##### - `vectorB` : `Table` = Second vector
-- ### @Returns
-- ##### 1. `angle` : `float`
-- difference in radians between the 2 vectors
function vectorAngleDifference(vectorA, vectorB)
    product = vectorDotProduct(vectorA, vectorB)
    return math.acos(product)
end