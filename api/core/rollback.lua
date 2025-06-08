---@meta
---Rollback
-----------

-- Used in `core.rollback_get_node_actions`.
---@class lt.RollbackAction
---@field actor string `"player:<name>"`, also `"liquid"`.
---@field pos lt.Vector
---@field time number
---@field oldnode lt.Node
---@field newnode lt.Node

-- Finds who has done something to a node, or near a node.
---@param pos lt.Vector
---@param range integer
---@param seconds number
---@param limit integer Maximum number of actions to search.
---@return lt.RollbackAction[]
function core.rollback_get_node_actions(pos, range, seconds, limit) end

---@param actor string `"player:<name>"`, also `"liquid"`.
---@param seconds number
---@return boolean, string log_messages
function core.rollback_revert_actions_by(actor, seconds) end
