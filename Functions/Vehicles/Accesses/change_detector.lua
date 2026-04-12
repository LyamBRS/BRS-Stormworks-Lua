-- [BRS] - [[ Information ]] --
-- `26/04/12`
-- ### Description
-- Detects any change in an access' robotic pivot.
-- Changes are outputed for only a tick.
-- Identifies if its now closed, or opened.
-- ### Used for
-- Tick detection, anything that became closed or became opened.
-- and you need to know for only a tick.
-- ### @Input
-- ##### - `previousHolder` : `table` = `[previouslyOpened, previouslyClosed]`
-- ##### - `accessPivot` : `float` = current pivot value
-- ##### - `closedValue` : `float` = the value at which its considered closed
-- ##### - `openedValue` : `float` = the value at which its considered opened
-- ### @Returns
-- ##### 1. `nowOpened` : `boolean` = The access is now opened. True for a tick
-- ##### 2. `nowClosed` : `boolean` = The access is now closed. True for a tick
function accessChangeDetection(previousHolder, accessPivot, closedValue, openedValue)
    if accessPivot == closedValue and not previousHolder[1] then
        previousHolder[1] = true
        previousHolder[2] = false
        return false, true
    end

    if accessPivot == openedValue and not previousHolder[2] then
        previousHolder[1] = false
        previousHolder[2] = true
        return true, false
    end

    return false, false
end