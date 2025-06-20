---@meta
---ItemStack
------------

---An `ItemStack` is a stack of items.
---
---It can be created via `ItemStack(x)`, where x is an ItemStack,
---an itemstring, a table or nil.
---
--- **Operators**
---
---* `stack1 == stack2`:
---* Returns whether `stack1` and `stack2` are identical.
---* Note: `stack1:to_string() == stack2:to_string()` is not reliable,
---  as stack metadata can be serialized in arbitrary order.
---* Note: if `stack2` is an itemstring or table representation of an
---  ItemStack, this will always return false, even if it is "equivalent".
---@class lt.ItemStack
local ItemStackObject = {}

---`ItemStack` constructor.
---@param x lt.Item
---@return lt.ItemStack
function ItemStack(x) end

---Defines the coloring of the bar that appears under damaged tools.
---If it is absent, the default behavior of green-yellow-red is used.
---
---```lua
---{
---    -- 'constant' or 'linear'
---    -- (nil defaults to 'constant')
---    blend = "linear",
---    color_stops = {
---        [0.0] = "#ff0000",
---        [0.5] = "slateblue",
---        [1.0] = {r=0, g=255, b=0, a=150},
---    }
---}
---```
---@class lt.WearBarColor
---@field blend
---|"linear" blends smoothly between each defined color point
---|"constant" each color starts at its defined point, and continues up to the next point
---|nil
---Specified as `ColorSpec` color values assigned to `float` durability keys.
---
---"Durability" is defined as `1 - (wear / 65535)`.
---@field color_stops table<number, lt.ColorSpec>

---Returns `true` if stack is empty.
---@return boolean
function ItemStackObject:is_empty() end

---@return string name ie: "default:stone"
function ItemStackObject:get_name() end

---Returns a boolean indicating whether the item was cleared.
---@param item_name string
---@return boolean cleared
function ItemStackObject:set_name(item_name) end

---Returns number of items on the stack.
---@return number
function ItemStackObject:get_count() end

---Returns a boolean indicating whether the item was cleared.
---@param count integer Unsigned 16 bit.
---@return boolean cleared
function ItemStackObject:set_count(count) end

---Returns tool wear (`0`-`65535`), `0` for non-tools.
---@return number
function ItemStackObject:get_wear() end

---Returns boolean indicating whether item was cleared.
---@param wear integer Unsigned 16 bit.
---@return boolean cleared
function ItemStackObject:set_wear(wear) end

---**DEPRECATED** Returns metadata (a string attached to an item stack).
---
---Use `stack:get_meta():get_string("")` instead.
---@return string
---@deprecated
function ItemStackObject:get_metadata() end

---**DEPRECATED**
---
---Use `stack:get_meta():set_string("", metadata)` instead.
---@param metadata string
---@return true
---@deprecated
function ItemStackObject:set_metadata(metadata) end

---* Returns the description shown in inventory list tooltips.
---* The engine uses this when showing item descriptions in tooltips.
---* Fields for finding the description, in order:
---  * `description` in item metadata (See [Item Metadata]);
---  * `description` in item definition;
---  * item name.
---@return string
function ItemStackObject:get_description() end

---* Returns the short description or nil.
---* Unlike the description, this does not include new lines.
---* Fields for finding the short description, in order:
---  * `short_description` in item metadata (See [Item Metadata]);
---  * `short_description` in item definition;
---  * first line of the description (From item meta or def, see `get_description()`);
---  * Returns nil if none of the above are set.
---@return string|nil
function ItemStackObject:get_short_description() end

---Removes all items from the stack, making it empty.
function ItemStackObject:clear() end

---Replace the contents of this stack.
---@param item string|table
function ItemStackObject:replace(item) end

---Returns the stack in itemstring form.
---@return string
function ItemStackObject:to_string() end

---Returns the stack in Lua table form.
---@return table
function ItemStackObject:to_table() end

---Returns the maximum size of the stack (depends on the item).
---@return number
function ItemStackObject:get_stack_max() end

---Returns `get_stack_max() - get_count()`.
---@return number
function ItemStackObject:get_free_space() end

---Returns `true` if the item name refers to a defined item type.
---@return boolean
function ItemStackObject:is_known() end

---Returns the item definition table.
---@return lt.ItemDef
function ItemStackObject:get_definition() end

---Returns the digging properties of the item, or those of the hand if none are
---defined for this item type.
---@return lt.ToolCaps
function ItemStackObject:get_tool_capabilities() end

---Increases wear by `amount` if the item is a tool, otherwise does nothing
---@param amount integer 0..65536
function ItemStackObject:add_wear(amount) end

---* Increases wear in such a way that, if only this function is called,
---  the item breaks after `max_uses` times.
---* Does nothing if item is not a tool or if `max_uses` is 0.
---@param max_uses integer 0..65536
function ItemStackObject:add_wear_by_uses(max_uses) end

---@return lt.WearBarColor wear bar parameters of the item, or nil if none are defined for this item type or in the stack's meta
function ItemStackObject:get_wear_bar_params() end

---Overrides the item's wear bar parameters
---
---A nil value will clear the override data and restore the original
---behavior.
---@param wear_bar_params? lt.WearBarColor
function set_wear_bar_params(wear_bar_params) end

---* Returns leftover `ItemStack`.
---* Put some item or stack onto this stack.
---@param item lt.Item
---@return lt.ItemStack leftover
function ItemStackObject:add_item(item) end

---Returns `true` if item or stack can be fully added to this one.
---@param item lt.Item
---@return boolean
function ItemStackObject:item_fits(item) end

---* Returns taken `ItemStack`.
---* Take (and remove) up to `n` items from this stack.
---@param n number|nil Default: `1`.
---@return lt.ItemStack taken
function ItemStackObject:take_item(n) end

---* Returns taken `ItemStack`.
---* Copy (don't remove) up to `n` items from this stack.
---@param n number|nil Default: `1`.
---@return lt.ItemStack taken
function ItemStackObject:peek_item(n) end

---* Returns `true` if this stack is identical to `other`.
---* Note: `stack1:to_string() == stack2:to_string()` is not reliable,
---  as stack metadata can be serialized in arbitrary order.
---* Note: if `other` is an itemstring or table representation of an
---  ItemStack, this will always return false, even if it is
---  "equivalent".
---@param other lt.Item
function ItemStackObject:equals(other) end

---@return lt.ItemStackMetaRef
function ItemStackObject:get_meta() end
