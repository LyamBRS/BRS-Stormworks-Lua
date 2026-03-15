-- [BRS] - Handles all the animation updates
for i=1, #g_animations do
    for j=1, 4 do
        animate(g_animations[i][j])
    end
end