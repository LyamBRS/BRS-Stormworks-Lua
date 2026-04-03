-- [BRS] - [[ INFORMATIONS ]] -
-- Goes through the buffer of detected targets at any angles
-- updates their time to live, and removes old targets.

-- [BRS] - Used for O(n) table replacement. Other solutions would've involved multiple passes.
write = 1

for read=1,#g_targets do
    target = g_targets[read]

    -- [BRS] - Updates to time to live
    target[c_targetTimeToLive] = target[c_targetTimeToLive] - 1

    -- [BRS] - TTL Management, sets up the path to cleaning old targets
    if target[c_targetTimeToLive] > 0 then
        g_targets[write] = target
        write = write + 1
    end
end

-- [BRS] - Removing old targets past their TTLs
for i = write, #g_targets do
    g_targets[i] = nil
end