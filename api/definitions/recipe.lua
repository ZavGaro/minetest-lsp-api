---@meta
---Crafting recipes
-------------------

-- Used by `core.register_craft`.
---@alias lt.CraftRecipe lt.CraftRecipeRepair|lt.CraftRecipeFuel|lt.CraftRecipeShaped|lt.CraftRecipeCooking|lt.CraftRecipeShapeless

---@class lt.CraftRecipeShaped
---@field output string|nil
---@field recipe string[][]|nil
-- Replace one input item with another item on crafting.
---@field replacements nil|{[1]:string, [2]:string}[]

---@class lt.CraftRecipeShapeless
---@field type "shapeless"|nil
---@field output string|nil
---@field recipe string[]|nil
-- Replace one input item with another item on crafting.
---@field replacements nil|{[1]:string, [2]:string}[]

-- Adds a shapeless recipe for *every* tool that doesn't have the `disable_repair=1`
-- group. Player can put 2 equal tools in the craft grid to get one "repaired" tool
-- back.
--
-- The wear of the output is determined by the wear of both tools, plus a
-- 'repair bonus' given by `additional_wear`. To reduce the wear (i.e. 'repair'),
-- you want `additional_wear` to be negative.
--
-- The formula used to calculate the resulting wear is:
--
--     65536 - ( (65536 - tool_1_wear) + (65536 - tool_2_wear) + 65536 * additional_wear )
--
-- The result is rounded and can't be lower than 0. If the result is 65536 or higher,
-- no crafting is possible.
---@class lt.CraftRecipeRepair
---@field type "toolrepair"|nil
---@field additional_wear number|nil Multiplier of 65536.

---@class lt.CraftRecipeCooking
---@field type "cooking"|nil
---@field output string|nil
---@field recipe string|nil
---@field cooktime number|nil

---@class lt.CraftRecipeFuel
---@field type "fuel"|nil
---@field recipe string|nil
---@field burntime number|nil
-- Replace one input item with another item on crafting.
---@field replacements nil|{[1]:string, [2]:string}[]
