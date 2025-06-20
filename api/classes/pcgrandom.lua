---@meta
---PcgRandom
------------

-- A 32-bit pseudorandom number generator. Uses PCG32, an algorithm of the permuted
-- congruential generator family, offering very strong randomness.
---@param seed integer 64-bit unsigned seed
---@param sequence integer|nil 64-bit unsigned sequence
---@return lt.PcgRandom
function PcgRandom(seed, sequence) end

-- A 32-bit pseudorandom number generator. Uses PCG32, an algorithm of the permuted
-- congruential generator family, offering very strong randomness.
--
-- It can be created via `PcgRandom(seed)` or `PcgRandom(seed, sequence)`.
---@class lt.PcgRandom
local rnd = {}

-- - Return next integer random number [`-2147483648`...`2147483647`].
---@param min integer|nil
---@param max integer|nil
---@return integer
function rnd:next(min, max) end

-- Return normally distributed random number [`min`...`max`].
--
-- This is only a rough approximation of a normal distribution with:
--
-- - `mean = (max - min) / 2`, and
-- - `variance = (((max - min + 1) ^ 2) - 1) / (12 * num_trials)`
-- - Increasing `num_trials` improves accuracy of the approximation.
---@param min number
---@param max number
---@param num_trials number
---@return integer
function rnd:rand_normal_dist(min, max, num_trials) end

---@return string # generator state encoded in string
function rnd:get_state() end

--- Restore generator state from encoded string
---@param state_string string
function rnd:set_state(state_string) end

