---@meta
---PseudoRandom
---------------

--[[
A 16-bit pseudorandom number generator. Uses a well-known LCG algorithm
introduced by K&R.

It can be created via `PseudoRandom(seed)`.

**Note**:
`PseudoRandom` is slower and has worse random distribution than `PcgRandom`.
Use `PseudoRandom` only if you need output to match the well-known LCG algorithm introduced by K&R.
Otherwise, use `PcgRandom`.
]]
---@class mt.PseudoRandom
local PseudoRandomClass

--- Create a pseudorandom number generator.
---@param seed number
---@return mt.PseudoRandom
function PseudoRandom(seed) end

-- Return next integer random number.
--
-- Either `max - min == 32767` or `max - min <= 6553` must be true
--- due to the simple implementation making a bad distribution otherwise.
-- making bad distribution otherwise.
---@param min number|nil Default: `0`
---@param max number|nil Default: `32767`
function PseudoRandomClass:next(min, max) end

--- Use returned number as seed in PseudoRandom constructor to restore
---@return number # state of pseudorandom generator as number
function PseudoRandomClass:get_state() end