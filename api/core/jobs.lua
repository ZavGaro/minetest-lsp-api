---@meta
---Timing
---------

-- Returned by `core.after`.
---@class mt.Job
local job = {}

-- Cancels the job function from being called.
function job:cancel() end

-- Call the function `func` after `time` seconds, may be fractional.
--
-- Jobs set for earlier times are executed earlier. If multiple jobs expire
-- at exactly the same time, then they are executed in registration order.
---@param time number
---@param func function
---@param ... unknown Arguments that will be passed to `func`.
---@return mt.Job
function core.after(time, func, ...) end

---Async environment
--------------------

-- Queue the function `func` to be ran in an async environment.
--
-- Note that there are multiple persistent workers and any of them may end up
-- running a given job.
--
-- The engine will scale the amount of worker threads automatically.
--
-- When `func` returns, the callback is called (in the normal environment)
-- with all of the return values as arguments.
--
-- **List of APIs available in an async environment:**
--
-- Classes:
--
-- - `AreaStore`
-- - `ItemStack`
-- - `ValueNoise`
-- - `ValueNoiseMap`
-- - `PseudoRandom`
-- - `PcgRandom`
-- - `SecureRandom`
-- - `VoxelArea`
-- - `VoxelManip`
--   - only if transferred into environment; can't read/write to map
-- - `Settings`
--
-- Class instances that can be transferred between environments:
--
-- - `ItemStack`
-- - `ValueNoise`
-- - `ValueNoiseMap`
-- - `VoxelManip`
--
-- Functions:
--
-- - Standalone helpers such as logging, filesystem, encoding, hashing or
--   compression APIs
-- - `core.request_insecure_environment` (same restrictions apply)
--
-- Variables:
--
-- - `core.settings`
-- - `core.registered_items`, `registered_nodes`, `registered_tools`,
--   `registered_craftitems` and `registered_aliases`
--   - with all functions and userdata values replaced by `true`, calling any
--     callbacks here is obviously not possible
---@param func function
---@param callback fun(...: any): any
---@param ... unknown Variable number of arguments that are passed to `func`.
function core.handle_async(func, callback, ...) end

-- Register a path to a Lua file to be imported
-- when an async environment is initialized.
--
-- You can use this to preload code which you can then call later
-- using `core.handle_async()`.
---@param path string
function core.register_async_dofile(path) end

---Register a metatable that should be preserved when data is transferred
---between the main thread and the async environment.
---
---Note that it is allowed to register the same metatable under multiple
---names, but it is not allowed to register multiple metatables under the
---same name.
---
---You must register the metatable in both the main environment
---and the async environment for this mechanism to work.
---@param name string string that identifies the metatable. It is recommended to follow the `modname:name` convention for this identifier.
---@param mt mt.MetaDataRef metatable to register.
function core.register_portable_metatable(name, mt) end