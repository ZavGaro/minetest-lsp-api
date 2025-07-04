---@meta
---InvRef
---------

-- An `InvRef` is a reference to an inventory.
--
-- When a player tries to put an item to a place where another item is, the items are *swapped*.
-- This means that all callbacks will be called twice (once for each action).
---@class lt.InvRef
local InvRef = {}

---Return `true` if list is empty.
---@param listname string
---@return boolean
function InvRef:is_empty(listname) end

---Get size of a list.
---@param listname string
---@return integer
function InvRef:get_size(listname) end

---* Set size of a list.
---* Returns `false` on error (e.g. invalid `listname` or `size`).
---@param listname string
---@param size integer
---@return boolean success
function InvRef:set_size(listname, size) end

---Get width of a list.
---@param listname string
---@return integer
function InvRef:get_width(listname) end

---Set width of list; currently used for crafting.
---@param listname string
---@param width integer
---@return boolean # `false` on error (e.g. invalid `listname` or `width`)
function InvRef:set_width(listname, width) end

---Get a copy of stack index in list.
---@param listname string
---@param index integer
---@return lt.ItemStack
function InvRef:get_stack(listname, index) end

---Copy `stack` to index in list.
---@param listname string
---@param index integer
---@param stack lt.Item
function InvRef:set_stack(listname, index, stack) end

---Return full list (list of `ItemStack`s) or `nil` if list doesn't exist (size 0).
---@param listname string
---@return lt.ItemStack[]?
function InvRef:get_list(listname) end

---Set full list (size will not change).
---@param listname string
---@param list lt.Item[]|nil
function InvRef:set_list(listname, list) end

---Returns table that maps listnames to inventory lists.
---@return table lists
function InvRef:get_lists() end

---Sets inventory lists (size will not change).
---@param lists table
function InvRef:set_lists(lists) end

---Add item somewhere in list, returns leftover `ItemStack`.
---@param listname string
---@param stack lt.ItemStack
---@return lt.ItemStack leftover
function InvRef:add_item(listname, stack) end

---Returns `true` if the stack of items can be fully added to the list.
---@param listname string
---@param stack lt.Item
---@return boolean
function InvRef:room_for_item(listname, stack) end

---* Returns `true` if the stack of items can be fully taken from the list.
---* If `match_meta` is false (default), only the items' names are compared.
---@param listname string
---@param stack lt.Item
---@param match_meta boolean|nil `false` Only compares names if unset.
---@return boolean
function InvRef:contains_item(listname, stack, match_meta) end

---* Take as many items as specified from the
---  list, returns the items that were actually removed (as an `ItemStack`).
---* Note that any item metadata is ignored, so attempting to remove a specific
---  unique item this way will likely remove the wrong one -- to do that use
---  `set_stack` with an empty `ItemStack`.
---@param listname string
---@param stack lt.Item
---@return lt.ItemStack
function InvRef:remove_item(listname, stack) end

---* Returns a location compatible to `core.get_inventory(location)`.
---* Returns `{type="undefined"}` in case location is not known.
---@return lt.InvLocation
function InvRef:get_location() end
