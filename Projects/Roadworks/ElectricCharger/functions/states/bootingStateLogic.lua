require("Variables.Animations.timeLeft")
require("Functions.Animations.Framework.setNewAnimationTarget")
require("Projects.Roadworks.ElectricCharger.functions.stationLight.stationLightWhenInnactive")
-- [BRS] - [[ Information ]] --
-- `2025/12/27`
-- ### Description
-- What the function is
-- ### Used for
-- Saving 188 minified characters at the cost of less details between
-- booting up and down. Both are similar due to this function.
-- ### @Input
-- ##### - `direction` : `boolean`
--      `true`: booting up
--      `false` : booting down
-- ### @Returns
-- None
function bootingStateLogic(direction)
    wantedAlpha = direction and 0 or 255
    finalLetterPosition = direction and 75 or -31
    topFade = direction and bootFadeAlphaTop or bootFadeAlphaBot
    botFade = direction and bootFadeAlphaBot or bootFadeAlphaTop

    ------ Logic
    if g_subState == 2 then
        if brsLogoSY[c_animationTimeLeft] < 75 then
            -- [BRS] - Last letter finished. Ready for main menu
            g_subState = 3
        end
    elseif g_subState == 1 then
        -- [BRS] - Wait for the last letter to finish animating.
        if brsLogoSweep[c_animationTimeLeft] == 20 then
            -- [BRS] - Last letter finished. Set them to dissapear
            setNewAnimationTarget(brsLogoRY, 20, 50)
        end

        if brsLogoSweep[c_animationTimeLeft] == 10 then
            -- [BRS] - Last letter finished. Set them to dissapear
            setNewAnimationTarget(brsLogoSY, 20, 50)
        end

        if brsLogoSY[c_animationTimeLeft] < 15 and brsLogoSweep[c_animationTimeLeft] == 0 then
            -- [BRS] - Last letter finished. Set them to dissapear
            setNewAnimationTarget(brsLogoBY, finalLetterPosition, 100)
            setNewAnimationTarget(brsLogoRY, finalLetterPosition, 100)
            setNewAnimationTarget(brsLogoSY, finalLetterPosition, 100)
            g_subState = 2
        end
    elseif g_subState == 0 then
        -- [BRS] - Set BRS letters to go down one by one.
        setNewAnimationTarget(brsLogoBY, 20, 50)
        setNewAnimationTarget(brsLogoSweep, 3, 30)
        setNewAnimationTarget(topFade, wantedAlpha, 50)
        setNewAnimationTarget(botFade, wantedAlpha, 80)
        g_subState = 1
    end

    ------ State outputs
    g_monitorState = true
    g_relayCable = true
    g_relayAntenna = true
    g_relayCharger = false
    g_relayDischarger = false
    stationLightWhenInnactive()
end