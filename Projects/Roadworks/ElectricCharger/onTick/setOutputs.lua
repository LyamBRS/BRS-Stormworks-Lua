-- [BRS] - [[information]]
-- Sets all the outputs handled by the station's system.
-- This must be done AFTER state execution.
-- This must be done BEFORE animations
-- This must always be executed regardless of the current state.

-- [BRS] - BOOLEAN
output.setBool(1,
    g_chargeButton[c_elementTouch][c_elementTouchPressed] or
    g_dischargeButton[c_elementTouch][c_elementTouchPressed] or
    g_noButton[c_elementTouch][c_elementTouchPressed] or
    g_yesButton[c_elementTouch][c_elementTouchPressed] or
    g_cancelChargingButton[c_elementTouch][c_elementTouchPressed] or
    g_okFinishedSessionButton[c_elementTouch][c_elementTouchPressed]
)
output.setBool(2,
    g_chargeButton[c_elementTouch][c_elementTouchReleased] or
    g_dischargeButton[c_elementTouch][c_elementTouchReleased] or
    g_noButton[c_elementTouch][c_elementTouchReleased] or
    g_yesButton[c_elementTouch][c_elementTouchReleased] or
    g_cancelChargingButton[c_elementTouch][c_elementTouchReleased] or
    g_okFinishedSessionButton[c_elementTouch][c_elementTouchReleased]
)
output.setBool(3, g_relayCharger)
output.setBool(4, g_relayDischarger)
output.setBool(5, g_monitorState)
output.setBool(6, g_currentBootSound==1)
output.setBool(7, g_currentBootSound==2)
output.setBool(8, g_currentBootSound==3)

-- [BRS] - NUMERICAL
output.setNumber(1, g_stationLight[1])
output.setNumber(2, g_stationLight[2])
output.setNumber(3, g_stationLight[3])