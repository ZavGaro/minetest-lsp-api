---@meta
---Privilege definition
-----------------------

-- Used by `core.register_privilege`.
---@class lt.PrivDef
---@field description string|nil Privilege description.
-- Whether to grant the privilege to singleplayer.
---@field give_to_singleplayer boolean|nil
-- Whether to grant the privilege to the server admin.
-- Uses value of `give_to_singleplayer` by default.
---@field give_to_admin boolean|nil
-- Called when given to player `name` by `granter_name`.
-- `granter_name` will be nil if the priv was granted by a mod.
--
-- * Note that this callback will be called twice if a player is
--   responsible, once with the player name, and then with a nil player name.
-- * Return true here to stop `register_on_priv_grant` or `revoke` being called.
---@field on_grant nil|fun(name:string, granter_name:string|nil):boolean|nil
-- Called when taken from player `name` by `revoker_name`.
-- `revoker_name` will be nil if the priv was revoked by a mod.
--
-- * Note that this callback will be called twice if a player is
--   responsible, once with the player name, and then with a nil player name.
-- * Return true here to stop `register_on_priv_grant` or `revoke` being called.
---@field on_revoke nil|fun(name:string, revoker_name:string|nil):boolean|nil
