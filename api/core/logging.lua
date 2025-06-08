---@meta
---Logging functions
--------------------

---@alias lt.LogLevel
---|"none"
---|"error"
---|"warning"
---|"action"
---|"info"
---|"verbose"

---@param level lt.LogLevel
---@param text string
function core.log(level, text) end

---@param text string
---Log level `"none"`.
function core.log(text) end

---Equivalent to `core.log(table.concat({...}, "\t"))`.
---@see core.log
function core.debug(...) end
