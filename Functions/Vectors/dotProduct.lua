-- [BRS] - [[ Information ]] --
-- `26/03/29`
-- ### Description
-- Performs the dot product of 2 vectors
-- ### Used for
-- Whatever you need the dot product for
-- ### @Input
-- ##### - `vectorA` : `Table` = {x,y,z}
-- ##### - `vectorB` : `Table` = {x,y,z}
-- ### @Returns
-- ##### 1. `product` : `float` = result of dot product
function vectorDotProduct(vectorA, vectorB)
    return vectorA[1] * vectorB[1] +
           vectorA[2] * vectorB[2] +
           vectorA[3] * vectorB[3]
end