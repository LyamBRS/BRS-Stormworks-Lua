-- [BRS] - [[ Information ]] --
-- `25/08/04`
-- ### Description
-- A BRIO constants that dictate how long you should await when you're receiving things.
-- Without this feature, programs could remain stuck until an END is received.
-- ### Used for
-- Uniformizing the maximum amount of awaiting Getters and Awaiters can do before calling it quits and raising errors.
-- ### Held data
-- 60
g_BRIO_max_waiting = 60