c_BrioChannel = 31
c_BusOutIndex = 5
c_BusInIndex = 4
g_BRIO_results = {}
c_BRIO_divider = -1
c_BRIO_end = -10
g_masterCommands = nil
g_BRIOMasterData = {0, 0, false, 0, 0, 0, 0}
c_CommandsIndex = 3
c_StageIndex = 1
c_executedAddressIndex = 7
c_ToExecuteIndex = 1
c_EntriesIndex = 2
c_callWhenDoneIndex = 3
c_StepIndex = 2
c_awaitedTimeIndex = 6
function BrioResetData(brioData)
    brioData[c_StageIndex] = 0
    brioData[c_StepIndex] = 0
    brioData[c_CommandsIndex] = false
    brioData[c_awaitedTimeIndex] = 0
    brioData[c_BusInIndex] = 0
    brioData[c_BusOutIndex] = 0
    brioData[c_executedAddressIndex] = 0
end
function BrioExecutor(brioData)
    busIn = brioData[c_BusInIndex]
    stage = brioData[c_StageIndex] + 1
    stageCommands = brioData[c_CommandsIndex]
    executionData = stageCommands[stage]
    executedAddress = brioData[c_executedAddressIndex]

    if g_BRIO_results[executedAddress] == nil then
        g_BRIO_results[executedAddress] = {}
    end

    if stage > #stageCommands then
        BrioResetData(brioData)
        return
    end

    g_BRIO_results[executedAddress][stage] = executionData[c_ToExecuteIndex](brioData, executionData[c_EntriesIndex], g_BRIO_results[executedAddress][stage])
    
    newStage = brioData[c_StageIndex]
    if newStage == stage and executionData[c_callWhenDoneIndex] ~= nil then
        executionData[c_callWhenDoneIndex]()
    end

    if busIn == c_BRIO_end or newStage > #stageCommands then
        BrioResetData(brioData)
    end
end
function BrioMasterManager(brioData, commands)
    if brioData[c_CommandsIndex] then
        BrioExecutor(brioData)
    end
end
function BrioSendNumber(brioData, entries)
    brioData[c_StageIndex] = brioData[c_StageIndex] + 1
    brioData[c_BusOutIndex] = entries[1]
end
c_BRIO_char_filler = string.char(30)
function BrioSendText(brioData, entries)
    toSend = entries[1]
    step = brioData[c_StepIndex]
    characters = string.sub(toSend, step+1, step+4)

    while #characters < 4 do
        characters = characters .. c_BRIO_char_filler
    end

    brioData[c_BusOutIndex] = string.unpack("f", characters)
    brioData[c_StepIndex] = brioData[c_StepIndex] + 4

    if brioData[c_StepIndex] > #toSend then
        brioData[c_StageIndex] = brioData[c_StageIndex] + 1
        brioData[c_StepIndex] = 0
    end
end
function BrioGetText(brioData, entries, textReceivedSoFar)
    packedCharacters = brioData[c_BusInIndex]
    if packedCharacters == c_BRIO_divider or packedCharacters == c_BRIO_end then
        brioData[c_StageIndex] = brioData[c_StageIndex] + 1
        return textReceivedSoFar
    end

    if packedCharacters == 0 then
        BrioResetData(brioData)
        return textReceivedSoFar
    end

    if textReceivedSoFar == nil then textReceivedSoFar = "" end

    decoded = string.pack("f", packedCharacters)
    decoded = string.gsub(decoded, c_BRIO_char_filler, "")
    return textReceivedSoFar..decoded
end
function BrioAwaitNumber(brioData, entries)
    awaiting = entries[1]
    maxAwaitTime = entries[2]

    if brioData[c_BusInIndex] == awaiting then
        brioData[c_StageIndex] = brioData[c_StageIndex] + 1
        brioData[c_awaitedTimeIndex] = 0
    else
        brioData[c_awaitedTimeIndex] = brioData[c_awaitedTimeIndex] + 1
        if brioData[c_awaitedTimeIndex] > maxAwaitTime then
            BrioResetData(brioData)
        end
    end
end
function BrioSetMasterCommand(brioData, commands, address)
    if not brioData[c_CommandsIndex] then
        brioData[c_CommandsIndex] = commands[address]
        brioData[c_executedAddressIndex] = address
    end
end
function BrioGetNumber(brioData, entries)
    brioData[c_StageIndex] = brioData[c_StageIndex] + 1
    return brioData[c_BusInIndex]
end

g_pressingCoordsX = 0
g_pressingCoordsY = 0
g_pressing = false

c_brasClosed = 2
c_brasLocked = 3
c_brasOpened = 1
c_brasSuccess = 7
c_brasUnlocked = 4
c_brasUnsupported = 6
c_brasIncorrectPassword = 5

antennaTransmit = false
g_onGoing = false
oldOngoing = false
handshakeSuccess = false
message = "BRAS"
error = false

resetTimer = 0
g_Accesses = {}

receivedAnswer = false 
handshakeAnswer = 0
receivedAccessID = 0
currentAccess = 1

oldLeftArrow = false
oldRightArrow = false
selectedAccess = 1

amountOfAccesses = 0
communicationAnimationTicks = 0
loadingDotsAnimation = 1

pingColor = {16,83,16}
pingPressedColor = {32,120,32}
disabledColor = {30,30,30}

pingButton = {pingColor, {16,83,16}}

arrowNormal = {48,48,48}
arrowPressed = {255,255,255}
arrowDisabled = {16,16,16}

leftArrow = {arrowNormal, {32,32,32}}
rightArrow = {arrowNormal, {32,32,32}}
backgroundColor = {4,4,4}
errorBackground = {16,2,2}
successBackground = {4,16,4}
loadingBackground = {4,4,16}

cardsColor = {8,8,8}
errorCards = {24,6,6}
successCards = {8,24,8}
loadingCards = {8,8,24}

textColor = {64,64,64}
errorText = {128,24,24}
successText = {32,128,32}
loadingText = {32,32,128}

cards = {cardsColor, {8,8,8}}
background = {backgroundColor, {4,4,4}}
text = {textColor, {64,64,64}}
loadingAnimationTexts = {
    ".  ",
    ".. ",
    "...",
    " ..",
    "  .",
    "   ",
}

function onTick()
if currentAccess then
    accessProperty = "Access" .. currentAccess

    id = property.getNumber(accessProperty .. ".id")
    if id == nil or id == 0 then
        currentAccess = false
    else
        password = property.getText(accessProperty .. ".password")
        name = property.getText(accessProperty .. ".name")

        if name == nil or name == "" then
            name = currentAccess
        end

        autoClose = property.getNumber(accessProperty .. ".closeTime")
        g_Accesses[id] = {currentAccess, password, c_brasClosed, false, name, autoClose, 0}
        currentAccess = currentAccess + 1
        amountOfAccesses = amountOfAccesses + 1
    end
end

    g_onGoing = g_BRIOMasterData[c_CommandsIndex] ~= false

    communicationAnimationTicks = communicationAnimationTicks + 1
    if communicationAnimationTicks>2 then
        loadingDotsAnimation = loadingDotsAnimation + 1
        if loadingDotsAnimation > 6 then
            loadingDotsAnimation = 1
        end
        communicationAnimationTicks = 0
    end

    if resetTimer > 0 then
        resetTimer = resetTimer - 1
        if resetTimer == 0 then
            Reset()
        end
    end

    if oldOngoing ~= g_onGoing then -- the communication started or stopped.
        oldOngoing = g_onGoing

        if not g_onGoing and not receivedAnswer then -- We never received an answer
            message = "  No  answer"
            error = true
            resetTimer = 200
        end

        if not g_onGoing and not handshakeSuccess and not error then -- Well, it seems like we stopped communicating but not the full thing happened!
            message = "BRIO error"
            error = true
            resetTimer = 200
        end

        if not g_onGoing and handshakeSuccess then -- we received right proper shit mate
            resetTimer = 200
            message = "ERR Unknown"
            message = handshakeAnswer == 0 and "ANS ERR: 0" or message
            message = handshakeAnswer == c_brasUnsupported and "op not valid" or message
            message = handshakeAnswer == c_brasIncorrectPassword and " Wrong  pass" or message
            message = handshakeAnswer == c_brasSuccess and "ERR: Success" or message
            
            message = (handshakeAnswer == c_brasLocked) and "Locked" or message
            message = (handshakeAnswer == c_brasClosed) and "Closed" or message
            message = (handshakeAnswer == c_brasOpened) and "Opened" or message
            
            message = receivedAccessID ~= selectedAccessID and "ERR: ID" or message
            if message ~= "Closed" and message ~= "Opened" then
                error = true
            end
        end
    end

    g_BRIOMasterData[c_BusInIndex] = input.getNumber(c_BrioChannel)

    if g_masterCommands == nil then
        g_masterCommands = {
            [-3103] = {
                {BrioSendNumber, {-3103}},
                {BrioSendNumber, {selectedAccessID}},
                {BrioSendNumber, {c_BRIO_end}},
                {BrioSendNumber, {0}, StopTransmitting},
                {BrioAwaitNumber, {-4103, 10}, ReceivedAnswer}, -- Address
                {BrioGetNumber, {}}, -- Access ID
                {BrioGetNumber, {}}, -- Answer
                {BrioAwaitNumber, {-10, 1}, HandshakeSuccess}
            }
        }
    end

    BrioMasterManager(g_BRIOMasterData, g_masterCommands)

    output.setNumber(c_BrioChannel, g_BRIOMasterData[c_BusOutIndex])
    g_pressing = input.getBool(1)
    g_pressingCoordsX = input.getNumber(3)
    g_pressingCoordsY = input.getNumber(4)

    reachedLimitLeft = selectedAccess <= 1
    reachedLimitRight = selectedAccess >= amountOfAccesses

    pressingLeftArrow = PressingInRectangle(0,12,14,11) and not g_onGoing and not reachedLimitLeft
    pressingRightArrow = PressingInRectangle(18,12,14,11) and not g_onGoing and not reachedLimitRight

    leftArrow[1] = arrowNormal
    rightArrow[1] = arrowNormal
    if pressingLeftArrow then SetBothColors(leftArrow, arrowPressed) end
    if pressingRightArrow then SetBothColors(rightArrow, arrowPressed) end

    leftArrow[1] = (g_onGoing or reachedLimitLeft) and arrowDisabled or leftArrow[1]
    rightArrow[1] = (g_onGoing or reachedLimitRight) and arrowDisabled or rightArrow[1]

    ColorTableLerp(leftArrow, .2)
    ColorTableLerp(rightArrow, .2)

    pressingPing = PressingInRectangle(0,24,32,8) and not g_onGoing

    pingButton[1] = pingColor
    if pressingPing then SetBothColors(pingButton, pingPressedColor) end

    pingButton[1] = g_onGoing and disabledColor or pingButton[1]

    if resetTimer > 0 then
        cards[1] = error and errorCards or successCards
        background[1] = error and errorBackground or successBackground
        text[1] = error and errorText or successText
    else
        cards[1] = g_onGoing and loadingCards or cardsColor
        background[1] = g_onGoing and loadingBackground or backgroundColor
        text[1] = g_onGoing and loadingText or textColor
    end

    ColorTableLerp(cards, .2)
    ColorTableLerp(background, .2)
    ColorTableLerp(text, .2)

    ColorTableLerp(pingButton, .2)
    if pressingLeftArrow ~= oldLeftArrow then
        oldLeftArrow = pressingLeftArrow
        if selectedAccess > 1 and pressingLeftArrow then
            selectedAccess = selectedAccess - 1
        end
    end

    if pressingRightArrow ~= oldRightArrow then
        oldRightArrow = pressingRightArrow
        if selectedAccess < amountOfAccesses and pressingRightArrow then
            selectedAccess = selectedAccess + 1
        end
    end

    if pressingPing and not g_onGoing then
        Reset()

        selectedAccessID = -2
        selectedAccessID, access = GetAccessFromNumber(selectedAccess)

        g_masterCommands[-3103][2][2][1] = selectedAccessID
        antennaTransmit = true
        BrioSetMasterCommand(g_BRIOMasterData, g_masterCommands, -3103)
    end

    output.setBool(1, antennaTransmit)
end

function onDraw()
    --------------------------------
    SetColor(background)
    screen.drawClear()

    SetColor(cards)
    screen.drawRect(0,0,31,3)
    screen.drawRectF(1,17,30,1)
    screen.drawRectF(0,18,32,14)

    --------------------------------
    SetColor(leftArrow)
    screen.drawRectF(1,20,1,1)
    screen.drawRectF(2,19,1,3)

    SetColor(rightArrow)
    screen.drawRectF(30,20,1,1)
    screen.drawRectF(29,19,1,3)

    SetColor(pingButton)
    screen.drawRectF(2,24,28,7)
    screen.drawRectF(1,25,30,5)
    screen.setColor(4,20,6)
    screen.drawText(7,25,"ping")

    --------------------------------
    SetColor(text)

    if not g_onGoing then
        screen.drawTextBox(1,5,30,11,message,0,0)
    else
        screen.drawTextBox(1,5,30,11,loadingAnimationTexts[loadingDotsAnimation],0,0)
    end

    _, access = GetAccessFromNumber(selectedAccess)
    accessName = "ERROR"
    if access ~= nil then
        accessName = access[5]
    end
    screen.drawTextBox(4,18,25,5,accessName,0,0)

    --------------------------------
    screen.drawRectF(1,1,(resetTimer/200)*30,2)
end

function HandshakeSuccess()
    handshakeSuccess = true
    receivedAccessID = g_BRIO_results[-3103][6]
    handshakeAnswer = g_BRIO_results[-3103][7]
    g_BRIO_results[-3103] = nil
end

function StopTransmitting()
    antennaTransmit = false
end

function ReceivedAnswer()
    receivedAnswer = true
end

function Reset()
    message = "BRAS"
    handshakeAnswer = 0
    selectedAccessID = currentAccessID
    antennaTransmit = false
    handshakeSuccess = false
    receivedAnswer = false
    receivedAccessID = 0
    error = false
    resetTimer = 0
end
function SetColor(array)
    color = array[2]
    screen.setColor(color[1],color[2],color[3])
end
function SetBothColors(array, wantedColor)
    array[1] = {}
    array[2] = {}
    for i=1,3 do
        color = wantedColor[i]
        array[1][i] = color
        array[2][i] = color
    end
end
function GetAccessFromNumber(number)
    for key, value in pairs(g_Accesses) do
        if value[1] == number then
            return key, value
        end
    end
end

function PressingInRectangle(x, y, w, h)
    return (g_pressingCoordsX >= x and g_pressingCoordsY >= y and g_pressingCoordsX <= x+w and g_pressingCoordsY <= y+h) and g_pressing
end
function ColorTableLerp(array, speed)
    for i=1,3 do
        current = array[2]
        current[i] = current[i] * (1-speed) + array[1][i] * speed
    end
end
