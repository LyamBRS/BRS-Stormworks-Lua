-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles the state the doors should have.
-- ## Where is this used?
-- Prosty main.lua
-- [BRS] - I could probably make a function to check the pressing arrays... That'd save me some characters?

if driverDoorPressed[1] ~= driverDoorPressed[2] then
	driverDoorPressed[2] = driverDoorPressed[1]

	if driverDoorPressed[1] then
		g_driverPivot = (g_driverPivot == c_pivotDriverClosed) and c_pivotDriverOpened or c_pivotDriverClosed
	end
end

if passengerDoorPressed[1] ~= passengerDoorPressed[2] then
	passengerDoorPressed[2] = passengerDoorPressed[1]

	if passengerDoorPressed[1] then
		g_passengerPivot = (g_passengerPivot == c_pivotPassengerClosed) and c_pivotPassengerOpened or c_pivotPassengerClosed
	end
end

if trunkPressed[1] ~= trunkPressed[2] then
	trunkPressed[2] = trunkPressed[1]

	if trunkPressed[1] then
		g_trunkPivot = (g_trunkPivot == c_pivotTrunkClosed) and c_pivotTrunkOpened or c_pivotTrunkClosed
	end
end

if hoodPressed[1] ~= hoodPressed[2] then
	hoodPressed[2] = hoodPressed[1]

	if hoodPressed[1] then
		g_hoodPivot = (g_hoodPivot == c_pivotHoodClosed) and c_pivotHoodOpened or c_pivotHoodClosed
	end
end

-- [BRS] - Close all management.
-- Closes all opened doors
if closeAllPressed[1] ~= closeAllPressed[2] then
	closeAllPressed[2] = closeAllPressed[1]

	if closeAllPressed[1] then
		g_hoodPivot = c_pivotHoodClosed
		g_trunkPivot = c_pivotTrunkClosed
		g_driverPivot = c_pivotDriverClosed
		g_passengerPivot = c_pivotPassengerClosed
	end
end