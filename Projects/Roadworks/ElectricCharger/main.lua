require("Projects.Roadworks.ElectricCharger.constants.constants")
require("Projects.Roadworks.ElectricCharger.functions.functions")

state = 0
function onTick()
    -- [BRS] - Temporary test of boot up logo
    if state == 2 then
        animate(brsLogo[1][c_yIndex])
        animate(brsLogo[2][c_yIndex])
        animate(brsLogo[3][c_yIndex])

        if brsLogo[3][c_yIndex][c_animationTimeLeft] == 0 then
            state = 3
        end
    end

    if state == 1 then -- Bring the logo to the middle of the screen
        animate(brsLogo[4])                     -- animate the sweeping
        animate(brsLogo[1][c_yIndex])           -- The B can already come downwards.
        sweep = brsLogo[4][c_animationCurrent]

        if sweep > 1 then
            animate(brsLogo[2][c_yIndex])
        end

        if sweep > 2 then
            animate(brsLogo[3][c_yIndex])
        end
        
        if brsLogo[3][c_yIndex][c_animationTimeLeft] == 0 then -- the S 
            setNewAnimationTarget(brsLogo[1][c_yIndex], 75, 50)
            setNewAnimationTarget(brsLogo[2][c_yIndex], 75, 50)
            setNewAnimationTarget(brsLogo[3][c_yIndex], 75, 50)
            state = 2
        end
    end

    if state == 0 then -- Set the animations up
        setNewAnimationTarget(brsLogo[1][c_yIndex], 20, 50)
        setNewAnimationTarget(brsLogo[2][c_yIndex], 20, 50)
        setNewAnimationTarget(brsLogo[3][c_yIndex], 20, 50)
        setNewAnimationTarget(brsLogo[4], 3, 30)
        state = 1
    end
end

function onDraw()
    require("Projects.Roadworks.ElectricCharger.onDraw.drawBackground")
    require("Projects.Roadworks.ElectricCharger.onDraw.drawingLogo")
end

require("Projects.Roadworks.ElectricCharger.beforeScript.beforeScript")