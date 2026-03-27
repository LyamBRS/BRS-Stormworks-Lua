-- [BRS] - [[ Information ]] --
-- `25/08/14`
-- ## Generic info:
-- #### MC : `Microcontroller ID`
-- #### SN : `Script number
-- ## What does this do?
-- Handles the gears shifting through the driver seat inputs and other various data.
-- ## Where is this used?
-- Prosty main.lua

-- [BRS] - Unless you're in neutral, leaving the seat should put the car in park.
-- otherwise, you have runnaway vehicles, but doing it for all the gears means
-- you cannot tow the car without being in it.
if not seatOccupied and selectedGear ~= c_gearNeutral then
	selectedGear = c_gearPark
else
	-- [BRS] - Shifting it only allowed if the vehicle is on.
	if seatUpDown ~= previousUpDown and carOn then -- the up/down arrows values 
		previousUpDown = seatUpDown

		-- [BRS] - Upshift
		if seatUpDown > 0 and selectedGear < c_maximumGearNumber then
			selectedGear = selectedGear + 1
		end

		-- [BRS] - Downshift
		if seatUpDown < 0 and selectedGear > c_minimumGearNumber then
			selectedGear = selectedGear - 1
		end
	end
end