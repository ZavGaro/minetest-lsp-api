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
---      as stack metadata can be serialized in arbitrary order.
---* Note: if `stack2` is an itemstring or table representation of an
---      ItemStack, this will always return false, even if it is "equivalent".
---@class mt.ItemStack
---@overload fun(x: mt.ItemStack|string|table|nil): mt.ItemStack
ItemStack = {}

---* Returns `true` if stack is empty.
---@return boolean
function ItemStack:is_empty() end

---@return string name ie: "default:stone"
function ItemStack:get_name() end

---* Returns a boolean indicating whether the item was cleared.
---@param item_name string
---@return boolean cleared
function ItemStack:set_name(item_name) end

---* Returns number of items on the stack.
---@return number
function ItemStack:get_count() end

---* Returns a boolean indicating whether the item was cleared.
---@param count integer Unsigned 16 bit.
---@return boolean cleared
function ItemStack:set_count(count) end

---* Returns tool wear (`0`-`65535`), `0` for non-tools.
---@return number
function ItemStack:get_wear() end

---* Returns boolean indicating whether item was cleared.
---@param wear integer Unsigned 16 bit.
---@return boolean cleared
function ItemStack:set_wear(wear) end

---* **DEPRECATED** Returns metadata (a string attached to an item stack).
---@return string
---@deprecated
function ItemStack:get_metadata() end

---* **DEPRECATED**
---@param metadata string
---@return true
---@deprecated
function ItemStack:set_metadata(metadata) end

---* Returns the description shown in inventory list tooltips.
---* The engine uses this when showing item descriptions in tooltips.
---* Fields for finding the description, in order:
---  * `description` in item metadata (See [Item Metadata]);
---  * `description` in item definition;
---  * item name.
---@return string
function ItemStack:get_description() end

---* Returns the short description or nil.
---* Unlike the description, this does not include new lines.
---* Fields for finding the short description, in order:
---  * `short_description` in item metadata (See [Item Metadata]);
---  * `short_description` in item definition;
---  * first line of the description (From item meta or def, see `get_description()`);
---  * Returns nil if none of the above are set.
---@return string|nil
function ItemStack:get_short_description() end

---* Removes all items from the stack, making it empty.
function ItemStack:clear() end

---* Replace the contents of this stack.
---@param item string|table
function ItemStack:replace(item) end

---* Returns the stack in itemstring form.
---@return string
function ItemStack:to_string() end

---* Returns the stack in Lua table form.
---@return table
function ItemStack:to_table() end

---* Returns the maximum size of the stack (depends on the item).
---@return number
function ItemStack:get_stack_max() end

---* Returns `get_stack_max() - get_count()`.
---@return number
function ItemStack:get_free_space() end

---* Returns `true` if the item name refers to a defined item type.
---@return boolean
function ItemStack:is_known() end

---* Returns the item definition table.
---@return table
function ItemStack:get_definition() end

---* Returns the digging properties of the item,
---  or those of the hand if none are defined for this item type.
---@return mt.ToolCaps
function ItemStack:get_tool_capabilities() end

---* Increases wear by `amount` if the item is a tool, otherwise does nothing
---@param amount integer 0..65536
function ItemStack:add_wear(amount) end

---* Increases wear in such a way that, if only this function is called,
---  the item breaks after `max_uses` times.
---* Does nothing if item is not a tool or if `max_uses` is 0.
---@param max_uses integer 0..65536
function ItemStack:add_wear_by_uses(max_uses) end

---* Returns leftover `ItemStack`.
---* Put some item or stack onto this stack.
---@param item mt.ItemStack
---@return mt.ItemStack leftover
function ItemStack:add_item(item) end

---* Returns `true` if item or stack can be fully added to this one.
---@param item mt.ItemStack
---@return boolean
function ItemStack:item_fits(item) end

---* Returns taken `ItemStack`.
---* Take (and remove) up to `n` items from this stack.
---@param n number|nil Default: `1`.
---@return mt.ItemStack taken
function ItemStack:take_item(n) end

---* Returns taken `ItemStack`.
---* Copy (don't remove) up to `n` items from this stack.
---@param n number|nil Default: `1`.
---@return mt.ItemStack taken
function ItemStack:peek_item(n) end

---* Returns `true` if this stack is identical to `other`.
---* Note: `stack1:to_string() == stack2:to_string()` is not reliable,
---  as stack metadata can be serialized in arbitrary order.
---* Note: if `other` is an itemstring or table representation of an
---  ItemStack, this will always return false, even if it is
---  "equivalent".
---@param other mt.ItemStack
function ItemStack:equals(other) end