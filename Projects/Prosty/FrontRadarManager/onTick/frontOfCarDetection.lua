-- [BRS] - [[ INFORMATIONS ]] -
-- Logic required to detect if anything is within a specific FOV of the front of the car.

currentDetection = false
for i=1, #g_targets do
    target = g_targets[i]

    difference = vectorAngleDifference(g_vehicleVector, target[c_targetVector])
    if math.abs(difference) < c_lightAutoHighDetectionFOV then
        currentDetection = true
        output.setNumber(4, target[1])
        output.setNumber(5, target[2])
        output.setNumber(6, target[3])

        output.setNumber(7, difference)
    end
end

-- [BRS] - Timer management, persists detection for a set amount of ticks
if currentDetection then
    g_frontDetectionPersistance = c_lightAutoHighDetectionDuration
else
    g_frontDetectionPersistance = g_frontDetectionPersistance - 1
    if g_frontDetectionPersistance < 0 then
        g_frontDetectionPersistance = 0
    end
end

-- [BRS] - Output for other scripts
g_nothingInFront = g_frontDetectionPersistance<=0