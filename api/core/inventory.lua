---@diagnostic disable: missing-return
---@meta
---Inventory
------------

---@class lt.InvLocation
---@field type "player"|"node"|"detached"|"undefined"
---@field name string|nil
---@field pos lt.Vector|nil

---@param location lt.InvLocation
---@return lt.InvRef
function core.get_inventory(location) end

-- Creates a detached inventory. If it already exists, it is cleared.
--
-- `player_name`: Make detached inventory available to one player
-- exclusively, by default they will be sent to every player (even if not used).
-- Note that this parameter is mostly just a workaround and will be removed
-- in future releases.
---@param name string
---@param callbacks lt.DetachedInvDef
---@param player_name string|nil
---@return lt.InvRef
function core.create_detached_inventory(name, callbacks, player_name) end

---@param name string
---@return boolean success
function core.remove_detached_inventory(name) end

---@param hp_change integer
---@param replace_with_item lt.Item
---@param itemstack lt.Item
---@param user lt.ObjectRef
---@param pointed_thing lt.PointedThing
---@return lt.ItemStack leftover
function core.do_item_eat(
  hp_change,
  replace_with_item,
  itemstack,
  user,
  pointed_thing
)
end
