require("Projects.Microprocessors.Dashboard.functions.states.stateOff")
-- [BRS] - [[information]]
-- Defines the initial state function that the dashboard
-- should be at.
-- This means that it should be executed after the definition of
-- the system's state functions
g_state = stateOff
g_subState = 0