---@meta
---Sounds
---------

---@alias lt.SoundHandle unknown

---@param spec lt.SimpleSoundSpec
---@param parameters lt.SoundParameters A sound parameter table.
---@param ephemeral boolean|nil Ephemeral sounds will not return a handle and can't be stopped or faded. It is recommend to use this for short sounds that happen in response to player actions (e.g. door closing). (default: false)
---@return lt.SoundHandle handle
function core.sound_play(spec, parameters, ephemeral) end

---@param handle lt.SoundHandle
function core.sound_stop(handle) end

---@param handle lt.SoundHandle
---@param step number
---@param gain number
function core.sound_fade(handle, step, gain) end
