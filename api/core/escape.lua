---@meta
---Escape sequences
-------------------

---The escape sequence sets the text color to `color`.
---@param color lt.ColorString
function core.get_color_escape_sequence(color) end

-- Equivalent to:
--
-- ```lua
-- core.get_color_escape_sequence(color) .. message ..
-- core.get_color_escape_sequence("#ffffff")
-- ```
---@param color lt.ColorString
---@param message string
function core.colorize(color, message) end

-- The escape sequence sets the background of the whole text element to
-- `color`. Only defined for item descriptions and tooltips.
---@param color lt.ColorString
function core.get_background_escape_sequence(color) end

-- Removes foreground colors added by `get_color_escape_sequence`.
---@param str string
function core.strip_foreground_colors(str) end

-- Removes background colors added by `get_background_escape_sequence`.
---@param str string
function core.strip_background_colors(str) end

-- Removes all color escape sequences.
---@param str string
function core.strip_colors(str) end
