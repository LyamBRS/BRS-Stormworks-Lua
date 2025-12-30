require("Projects.Roadworks.ElectricCharger.functions.states.stateMainMenu")
require("Projects.Roadworks.ElectricCharger.functions.states.stateFinishedSession")
require("Projects.Roadworks.ElectricCharger.functions.stationLight.stationLightWhenInnactive")
require("Projects.Roadworks.ElectricCharger.functions.elements.createUIXAnimation")
require("Variables.Monitor.Elements.surface")
require("Variables.Monitor.Elements.surface.x")
require("Variables.Monitor.Elements.surface.y")
require("Variables.Monitor.Elements.touch")
require("Variables.Monitor.Elements.touch.released")


-- [BRS] - [[ Information ]] --
-- `2025/12/28`
-- ### Description
-- Actual charging and discharge state.
-- If the electric store stays the same for 60 ticks, it'll assess if it
-- was a successful charging session or not.
-- ### Used for
-- Actually charging the vehicle that's connected to the station.
-- ### State's outputs
-- - Monitor            -> `true`
-- - Antenna relay      -> `true`
-- - Charger relay      -> `false` | `true`
-- - Discharger relay   -> `false` | `true`
-- - RGB ->
--      - `green`   if vehicle antenna signal == 0
--      - `blue`    if vehicle antenna signal > 0
--      - `red`     if inf electric is detected
-- ### @Input
-- None
-- ### @Returns
-- None
function stateCharger()
    -- print("state: stateCharger")
    direction = g_wantsToCharge and c_mainMenuToDischargeX or c_mainMenuToChargingX

    progressTopColors = g_batteryChargeBarTop[c_elementColors]
    progressBotColors = g_batteryChargeBarBot[c_elementColors]
    textAreaColors = g_chargingVehicleText[c_elementColors]

    ------ Logic
    width = g_batteryChargeBarBot[c_elementSurface][c_elementSurfaceW][c_animationCurrent]-2
    wanted = width * g_electricStore
    setNewAnimationTarget(g_batteryChargeBarTop[c_elementSurface][c_elementSurfaceW], wanted, 0)

    if g_subState == 3 then -- Ensure the electric store moves. if it doesn't in 30 ticks... There's nothing to do!
        -- [BRS] - If the electric store hasn't moved, count down. Otherwise, reset the counter.
        storesNotTheSame = g_previousElectricStore ~= g_electricStore
        g_electricCounter = storesNotTheSame and 20 or g_electricCounter-1
        g_previousElectricStore = g_electricStore

        -- [BRS] - Need to check if it ever moved.
        if storesNotTheSame then
            itMoved = true
        end

        if g_electricCounter < 0 then
            -- [BRS] - It stopped moving!
            if itMoved then
                -- [BRS] - it did stop moving and it did move before!
                g_state = stateFinishedSession
            else
                -- [BRS] - ok... it did stop moving but it never really ever did.
                g_state = stateAwaitVehicleConnection
            end
        end
    elseif g_subState == 2 then -- turn on the charger and wait a bit before checking the electric store
        startProceedure = true
        g_previousElectricStore = g_electricStore
        delayBeforeCheck = delayBeforeCheck + 1
        if delayBeforeCheck > 20 then
            g_subState = 3
        end
    elseif g_subState == 1 then -- wait for the menu to be fully deployed
        if g_chargingVehicleText[c_elementSurface][c_elementSurfaceX][c_animationTimeLeft] == 0 then
            g_previousElectricStore = g_electricStore
            g_subState = 2
        end

    elseif g_subState == 0 then -- deploy menu
        g_subState = 1
        
        createUIXAnimation(g_chargingVehicleText, direction, c_textAreaXShown)
        createUIXAnimation(g_cancelChargingButton, direction, c_buttonXShown)
        createUIXAnimation(g_batteryChargeBarTop, direction, c_buttonXShown+1)
        createUIXAnimation(g_batteryChargeBarBot, direction, c_buttonXShown)

        -- Hard reset progress bar colors
        progressTopColors[1] = createQuadAnimationTable(16, 16, 16, 255, quintInOutAnimation)
        progressTopColors[2] = createQuadAnimationTable(16, 16, 16, 255, quintInOutAnimation)
        progressBotColors[1] = createQuadAnimationTable(16, 16, 16, 128, quintInOutAnimation)
        progressBotColors[2] = createQuadAnimationTable(16, 16, 16, 128, quintInOutAnimation)
        textAreaColors[1] = createQuadAnimationTable(16, 16, 16, 128, quintInOutAnimation)
        textAreaColors[2] = createQuadAnimationTable(16, 16, 16, 128, quintInOutAnimation)

        -- Define progress bar flipping stuff
        animationStep = true
        g_electricCounter = 20
        itMoved = false
        startProceedure = false
        delayBeforeCheck = 0
        g_currentSessionTimer = 0
    end

    -- Color animations
    colorAnimationIndex = g_wantsToCharge and c_elementColorG or c_elementColorR

    bottomColorA = progressBotColors[1][colorAnimationIndex]
    bottomColorB = progressBotColors[2][colorAnimationIndex]
    textColorA = textAreaColors[1][colorAnimationIndex]
    textColorB = textAreaColors[2][colorAnimationIndex]

    colorASpeed = g_wantsToCharge and 15 or 30
    colorBSpeed = g_wantsToCharge and 30 or 15

    if bottomColorA[c_animationTimeLeft] == 0 and bottomColorB[c_animationTimeLeft] == 0 then
        animationStep = not animationStep
        wantedColor = animationStep and 16 or 255
        setNewAnimationTarget(bottomColorA, wantedColor, colorASpeed)
        setNewAnimationTarget(bottomColorB, wantedColor, colorBSpeed)
        setNewAnimationTarget(textColorA, wantedColor, colorASpeed)
        setNewAnimationTarget(textColorB, wantedColor, colorBSpeed)
    end

    -- Right gradient color for the top of the progress bar.
    -- This is done by lerping it like a gradient, but with the end where
    -- it actually currently is.
    rightRed = lerpAnimation(255, 0, g_electricStore)
    rightGreen = lerpAnimation(0, 255, g_electricStore)

    setNewAnimationTarget(progressTopColors[2][c_elementColorR], rightRed, 0)
    setNewAnimationTarget(progressTopColors[2][c_elementColorG], rightGreen, 0)

    -- Session timer management
    g_currentSessionTimer = startProceedure and g_currentSessionTimer+1 or g_currentSessionTimer

    ------ State outputs
    g_monitorState = true
    g_relayAntenna = true
    g_relayCharger = g_wantsToCharge and startProceedure
    g_relayDischarger = not g_wantsToCharge and startProceedure
    stationLightWhenInnactive()

    ------ NEXT STATE HANDLING -
    -- [BRS] - The signal strength detected something! The player connected their vehicle.
    g_state = g_cancelChargingButton[c_elementTouch][c_elementTouchReleased] and stateMainMenu or g_state

    -- [BRS] - The player cancelled the operation. Back to the main menu.
    if g_state ~= stateCharger then
        g_subState = 0
        setNewAnimationTarget(g_chargingVehicleText[c_elementSurface][c_elementSurfaceX], direction, c_UIShiftDuration)
        setNewAnimationTarget(g_cancelChargingButton[c_elementSurface][c_elementSurfaceX], direction, c_UIShiftDuration)
        setNewAnimationTarget(g_batteryChargeBarTop[c_elementSurface][c_elementSurfaceX], direction, c_UIShiftDuration)
        setNewAnimationTarget(g_batteryChargeBarBot[c_elementSurface][c_elementSurfaceX], direction, c_UIShiftDuration)

        -- Ensure the animation for the charger doesn't suddently stop
        setNewAnimationTarget(bottomColorA, 16, 30)
        setNewAnimationTarget(bottomColorB, 16, 15)

        -- Ensure the progress bar resets
        setNewAnimationTarget(g_batteryChargeBarTop[c_elementSurface][c_elementSurfaceW], 0, c_UIShiftDuration)
    end
end