---@diagnostic disable: unused-local, missing-return
---@meta
---ObjectRef
------------

---@class lt.ObjectRefProto
local ObjectRef = {}

-- A reference to an entity.
--
-- This is basically a reference to a C++ `ServerActiveObject`.
--
-- **Advice on handling `ObjectRefs`**
--
-- When you receive an `ObjectRef` as a callback argument or from another API
-- function, it is possible to store the reference somewhere and keep it around.
-- It will keep functioning until the object is unloaded or removed.
--
-- However, doing this is **NOT** recommended - `ObjectRefs` should be "let go"
-- of as soon as control is returned from Lua back to the engine.
-- Doing so is much less error-prone and you will never need to wonder if the
-- object you are working with still exists.
--
-- If this is not feasible, you can test whether an `ObjectRef` is still valid
-- via `object:is_valid()`.
-- 
-- Getters may be called for invalid objects and will return nothing then.
-- All other methods should not be called on invalid objects.
---@alias lt.ObjectRef lt.LuaObjectRef|lt.PlayerObjectRef

---`property = nil` is equivalent to no override on that property
---@class lt.BoneOverride
---@field position? lt.BoneOverrideProperty
---@field rotation? lt.BoneOverrideProperty
---@field scale? lt.BoneOverrideProperty

---@class lt.BoneOverrideProperty
---@field vec lt.Vector in the same coordinate system as the model, and in degrees for rotation
---Old and new values are interpolated over this timeframe (in seconds)
---@field interpolation number
---If set to `false`, the override will be relative to the animated property:
---* Transposition in the case of `position`;
---* Composition in the case of `rotation`;
---* Multiplication in the case of `scale`
---@field absolute boolean

---@return boolean valid whether the object is valid
function ObjectRef:is_valid() end

---@return lt.Vector|nil
function ObjectRef:get_pos() end

---* Sets the position of the object.
---* No-op if object is attached.
---@param pos lt.Vector
function ObjectRef:set_pos(pos) end

---* Changes position by adding to the current position.
---* No-op if object is attached.
---* `pos` is a vector `{x=num, y=num, z=num}`.
---* In comparison to using `set_pos`, `add_pos` will avoid synchronization problems.
---@param pos lt.Vector
function ObjectRef:set_pos(pos) end

---@return lt.Vector|nil
function ObjectRef:get_velocity() end

---* In comparison to using `get_velocity`, adding the velocity and then using
--- `set_velocity`, `add_velocity` is supposed to avoid synchronization problems.
--- Additionally, players also do not support `set_velocity`.
---* If object is a player:
---  * Does not apply during `free_move`.
---  * Note that since the player speed is normalized at each move step,
---    increasing e.g. Y velocity beyond what would usually be achieved
---    (see: physics overrides) will cause existing X/Z velocity to be reduced.
---  * Example: `add_velocity({x=0, y=6.5, z=0})` is equivalent to
---    pressing the jump key (assuming default settings)
---@param vel lt.Vector
function ObjectRef:add_velocity(vel) end

---* Does an interpolated move for Lua entities for visually smooth transitions.
---* If `continuous` is true, the Lua entity will not be moved to the current
---      position before starting the interpolated move.
---* For players this does the same as `set_pos`,`continuous` is ignored.
---* No-op if object is attached.
---@param pos lt.Vector
---@param continuous boolean|nil Default: `false`.
function ObjectRef:move_to(pos, continuous) end


---* Punches the object, triggering all consequences a normal punch would have.
---* If `direction` equals `nil` and `puncher` does not equal `nil`, `direction`
--- will be automatically filled in based on the location of `puncher`.
--- 
--- Arguments `time_from_last_punch`, `tool_capabilities`, and `dir`
--- will be replaced with a default value when the caller sets them to `nil`.
---@param puncher? lt.ObjectRef
---@param time_from_last_punch number|nil Time since last punch action.
---@param tool_capabilities lt.ToolCaps|nil
---@param dir lt.Vector|nil Direction vector of punch
---@return number tool_wear
function ObjectRef:punch(
  puncher,
  time_from_last_punch,
  tool_capabilities,
  dir
)
end

---* Simulates using the 'place/use' key on the object
---* Triggers all consequences as if a real player had done this
---@param clicker lt.ObjectRef
function ObjectRef:right_click(clicker) end

---Returns number of health points.
---@return number|nil
function ObjectRef:get_hp() end

---* Set number of health points.
---* Is limited to the range of 0 ... 65535 (2^16 - 1).
---* For players: HP are also limited by `hp_max` specified in object properties.
---@param hp number
---@param reason string|nil See in register_on_player_hpchange
function ObjectRef:set_hp(hp, reason) end

---Returns an `InvRef` for players, otherwise returns `nil`.
---@return lt.InvRef|nil
function ObjectRef:get_inventory() end

---Returns the name of the inventory list the wielded item is in.
---@return string|nil
function ObjectRef:get_wield_list() end

---@return number|nil # The wield list index of the wielded item (starting with 1).
function ObjectRef:get_wield_index() end

---@return lt.ItemStack|nil # A copy of the wielded item.
function ObjectRef:get_wielded_item() end

---Replaces the wielded item, returns `true` if successful.
---@param item lt.Item
---@return boolean true If successful.
function ObjectRef:set_wielded_item(item) end

---Returns a table with all of the object's armor group ratings.
---@return table|nil `{group1_name = rating, group2_name = rating, ...}` or `nil`.
function ObjectRef:get_armor_groups() end

---* Sets the object's full list of armor groups.
---* Note: all armor groups not in the table will be removed.
---@param group_table table `{group1_name = rating, group2_name = rating, ...}`
function ObjectRef:set_armor_groups(group_table) end

---* Sets the object animation parameters and (re)starts the animation.
---* Animations only work with a `"mesh"` visual.
---
---@param frame_range { x: number, y: number }|nil Default `{x=1, y=1}`. Beginning and end frame (as specified in the mesh file). <br> * Animation interpolates towards the end frame but stops when it is reached. <br> * If looped, there is no interpolation back to the start frame. <br> * If looped, the model should look identical at start and end. <br> * Only integer numbers are supported.
---@param frame_speed number|nil Default: `15.0`. How fast the animation plays, in frames per second.
---@param frame_blend number|nil Default: `0.0`.
---@param frame_loop boolean|nil Default: `true`. If `true`, animation will loop. If false, it will play once.
function ObjectRef:set_animation(
  frame_range,
  frame_speed,
  frame_blend,
  frame_loop
)
end

---@return { x: number, y: number}|nil frame_range
---@return number|nil frame_speed
---@return number|nil frame_blend
---@return boolean|nil frame_loop
function ObjectRef:get_animation() end

--- * Sets the frame speed of the object's animation.
--- * Unlike `set_animation`, this will not restart the animation.
--- * `frame_speed`: See `set_animation`.
---@param frame_speed number|nil Default: `15.0`.
function ObjectRef:set_animation_frame_speed(frame_speed) end

--- * Attaches object to `parent`.
--- * See 'Attachments' section for details.
---@param parent lt.ObjectRef
---@param bone string|nil Default: `""`(the root bone). Bone to attach to.
---@param position lt.Vector|nil Default: `{x=0, y=0, z=0}`. Relative position.
---@param rotation lt.Vector|nil Default: `{x=0, y=0, z=0}`. Relative rotation in degrees.
---@param forced_visible boolean|nil Default: `false`. Should appear in first person?
function ObjectRef:set_attach(
  parent,
  bone,
  position,
  rotation,
  forced_visible
)
end

---* This command may fail silently (do nothing) when it would result
---  in circular attachments.
---* Returns current attachment parameters or nil if it isn't attached.
---* If attached, returns `parent`, `bone`, `position`, `rotation`, `forced_visible`.
---@return lt.ObjectRef|nil parent
---@return string|nil bone The root bone.
---@return lt.Vector|nil position Relative position.
---@return lt.Vector|nil rotation Relative rotation in degrees.
---@return boolean|nil forced_visible Should appear in first person?
function ObjectRef:get_attach() end

---Returns a list of ObjectRefs that are attached to the object.
---@return lt.ObjectRef[]|nil
function ObjectRef:get_children() end
--- Detaches object. No-op if object was not attached.
function ObjectRef:set_detach() end

---Shorthand for `set_bone_override(bone, {position = position, rotation = rotation:apply(math.rad)})` using absolute values.
---* **Note:** Rotation is in degrees, not radians.
---* **Deprecated:** Use `set_bone_override` instead.
---@param bone string|nil Default: `""`. The root bone.
---@param position lt.Vector|nil Default: `{x=0, y=0, z=0}`. Relative position.
---@param rotation lt.Vector|nil Default: `{x=0, y=0, z=0}`.
---@deprecated
function ObjectRef:set_bone_position(bone, position, rotation) end

--- `override = nil` (including omission) is shorthand for `override = {}` which clears the override
--- * **Note:** Unlike `set_bone_position`, the rotation is in radians, not degrees.
--- * Compatibility note: Clients prior to 5.9.0 only support absolute position and rotation.
---   All values are treated as absolute and are set immediately (no interpolation).
---@param bone string
---@param override lt.BoneOverride
function ObjectRef:set_bone_override(bone, override) end

--- * Shorthand for `get_bone_override(bone).position.vec, get_bone_override(bone).rotation.vec:apply(math.deg)`.
--- * **Deprecated:** Use `get_bone_override` instead.
---@param bone string
---@return lt.Vector|nil position, lt.Vector|nil rotation
---@deprecated
function ObjectRef:get_bone_position(bone) end

--- **Note:** Unlike `get_bone_position`, the returned rotation is in radians, not degrees.
---@param bone string
---@return lt.BoneOverride
function ObjectRef:get_bone_override(bone) end

---@return table<string, lt.BoneOverride> # all bone overrides as table `{[bonename] = override, ...}`
function ObjectRef:get_bone_override(bone) end

--- * set a number of object properties in the given table
--- * only properties listed in the table will be changed
--- * see the [Object properties](https://github.com/luanti-org/luanti/blob/master/doc/lua_api.md#object-properties) section for details
---@param property_table table
function ObjectRef:set_properties(property_table) end

---@return table|nil
function ObjectRef:get_properties() end

---@return boolean
function ObjectRef:is_player() end

---@class lt.NameTagAttributes
---@field text string|nil
---@field color lt.ColorSpec|nil
---@field bgcolor lt.ColorSpec|nil

--- * Returns a table with the attributes of the nametag of an object.
--- * A nametag is a HUD text rendered above the object.
---@return lt.NameTagAttributes|nil
function ObjectRef:get_nametag_attributes() end

---Sets the attributes of the nametag of an object.
---@param attrs lt.NameTagAttributes
function ObjectRef:set_nametag_attributes(attrs) end

---Lua entity only (no-op for other objects).
---@class lt.LuaObjectRef : lt.ObjectRefProto
local LuaObjectRef = {}

---* Remove object.
---* The object is removed after returning from Lua. However the `ObjectRef`
---  itself instantly becomes unusable with all further method calls having
---  no effect and returning `nil`.
function LuaObjectRef:remove() end

---@param vel lt.Vector
function LuaObjectRef:set_velocity(vel) end

---@param acc lt.Vector
function LuaObjectRef:set_acceleration(acc) end

---@return lt.Vector
function LuaObjectRef:get_acceleration() end

---* X is pitch (elevation), Y is yaw (heading) and Z is roll (bank).
---* Does not reset rotation incurred through `automatic_rotate`.
---* Remove & read your objects to force a certain rotation.
---@param rot lt.Vector (radians)
function LuaObjectRef:set_rotation(rot) end

---@return lt.Vector (radians)
function LuaObjectRef:get_rotation() end

---Sets the yaw in radians (heading).
---@param yaw number
function LuaObjectRef:set_yaw(yaw) end

---Returns number in radians.
---@return number
function LuaObjectRef:get_yaw() end

---* Set a texture modifier to the base texture, for sprites and meshes.
---* When calling `set_texture_mod` again, the previous one is discarded.
---@param mod string Texture modifier.
function LuaObjectRef:set_texture_mod(mod) end

---Returns current texture modifier.
---@return string mod Texture modifier.
function LuaObjectRef:get_texture_mod() end

---* Specifies and starts a sprite animation.
---* Only used by `sprite` and `upright_sprite` visuals
---* Animations iterate along the frame `y` position.
---  * First column:  subject facing the camera
---  * Second column: subject looking to the left
---  * Third column:  subject backing the camera
---  * Fourth column: subject looking to the right
---  * Fifth column:  subject viewed from above
---  * Sixth column:  subject viewed from below
---@param start_frame {x: number, y: number}|nil Default: `{x=0, y=0}`. The coordinate of the first frame.
---@param num_frames number|nil Default: `1`. Total frames in the texture.
---@param framelength number|nil Default: `0.2`. Time per animated frame in seconds.
---@param select_x_by_camera boolean|nil Default: `false`. Only for visual = `sprite`. Changes the frame `x` position according to the view direction.
function LuaObjectRef:set_sprite(
  start_frame,
  num_frames,
  framelength,
  select_x_by_camera
)
end

---**Deprecated**: Use `:get_luaentity().name` instead.
---@deprecated
function LuaObjectRef:get_entity_name() end

---@return any # The object's associated luaentity table. Otherwise returns `nil` (e.g. for players)
function LuaObjectRef:get_luaentity() end

---Player only (no-op for other objects).
---@class lt.PlayerObjectRef : lt.ObjectRefProto
local PlayerObjectRef = {}

---@return string name `""` if is not a player.
function PlayerObjectRef:get_player_name() end

---**DEPRECATED**, use get_velocity() instead.
---@deprecated
---@return lt.Vector|nil
function PlayerObjectRef:get_player_velocity() end

---**DEPRECATED**, use add_velocity(vel) instead.
---@deprecated
---@param vel lt.Vector|nil
function PlayerObjectRef:add_player_velocity(vel) end

---Get camera direction as a unit vector.
---@return lt.Vector|nil
function PlayerObjectRef:get_look_dir() end

---* Pitch in radians.
---* Angle ranges between -pi/2 and pi/2, which are straight up and down
---  respectively.
---@return number|nil
function PlayerObjectRef:get_look_vertical() end

---* Yaw in radians.
---* Angle is counter-clockwise from the +z direction.
---@return number|nil
function PlayerObjectRef:get_look_horizontal() end

---Sets look pitch.
---@param radians number Angle from looking forward, where positive is downwards.
function PlayerObjectRef:set_look_vertical(radians) end

---Sets look yaw.
---@param radians number Angle from the +z direction, where positive is counter-clockwise.
function PlayerObjectRef:set_look_horizontal(radians) end

---* Pitch in radians - **Deprecated** as broken. Use `get_look_vertical`.
---* Angle ranges between -pi/2 and pi/2, which are straight down and up
---  respectively.
---@deprecated
---@return number|nil
function PlayerObjectRef:get_look_pitch() end

---* Yaw in radians - **Deprecated** as broken. Use `get_look_horizontal`.
---* Angle is counter-clockwise from the +x direction.
---@deprecated
---@return number|nil
function PlayerObjectRef:get_look_yaw() end

---Sets look pitch - **Deprecated**. Use `set_look_vertical`.
---@deprecated
---@param radians number Angle from looking forward, where positive is downwards.
function PlayerObjectRef:set_look_pitch(radians) end

---Sets look yaw - **Deprecated**. Use `set_look_horizontal`.
---@deprecated
---@param radians number
function PlayerObjectRef:set_look_yaw(radians) end

---Returns player's breath.
---@return number|nil
function PlayerObjectRef:get_breath() end

---* Sets player's breath
---* values:
---  * `0`: player is drowning
---  * max: bubbles bar is not shown
---  * See [Object properties] for more information
---* Is limited to range 0 ... 65535 (2^16 - 1)
---@param value number
function PlayerObjectRef:set_breath(value) end

---* Sets player's FOV.
---* Set `fov` to 0 to clear FOV override.
---@param fov number Field of View (FOV) value.
---@param is_multiplier boolean|nil Default: `false`. Set to `true` if the FOV value is a multiplier.
---@param transition_time number|nil Default: `0`. If defined, enables smooth FOV transition. Interpreted as the time (in seconds) to reach target FOV. If set to 0, FOV change is instantaneous.
function PlayerObjectRef:set_fov(fov, is_multiplier, transition_time) end

---@return number|nil fov Server-sent FOV value. Returns 0 if an FOV override doesn't exist.
---@return boolean|nil is_multiplier Indicating whether the FOV value is a multiplier.
---@return number|nil transition_time (in seconds) taken for the FOV transition. Set by `set_fov`.
function PlayerObjectRef:get_fov() end

---**DEPRECATED**, use set_meta() instead.
---@deprecated
---@param attribute string
---@param value string|number|nil
function PlayerObjectRef:set_attribute(attribute, value) end

---**DEPRECATED**, use set_meta() instead.
---@deprecated
---@param attribute string
---@return string|nil value
function PlayerObjectRef:get_attribute(attribute) end

---@return lt.PlayerMetaRef|nil
function PlayerObjectRef:get_meta() end

---* Redefine player's inventory form.
---* Should usually be called in `on_joinplayer`
---* If `formspec` is `""`, the player's inventory is disabled.
--- @param formspec string
function PlayerObjectRef:set_inventory_formspec(formspec) end

---Returns a formspec string.
--- @return string|nil
function PlayerObjectRef:get_inventory_formspec() end

---* The formspec string will be added to every formspec shown to the user,
---  except for those with a no_prepend[] tag.
---* This should be used to set style elements such as background[] and
---  bgcolor[], any non-style elements (eg: label) may result in weird behavior.
---* Only affects formspecs shown after this is called.
---@param formspec string
function PlayerObjectRef:set_formspec_prepend(formspec) end

---Returns a formspec string.
---@return string formspec|nil
function PlayerObjectRef:get_formspec_prepend() end

---* Returns table with player pressed keys.
---* The table consists of fields with the following boolean values
---  representing the pressed keys: `up`, `down`, `left`, `right`, `jump`,
---  `aux1`, `sneak`, `dig`, `place`, `LMB`, `RMB`, and `zoom`.
---* The fields `LMB` and `RMB` are equal to `dig` and `place` respectively,
---  and exist only to preserve backwards compatibility.
---* Returns an empty table `{}` if the object is not a player.
---@return { up: boolean|nil, down: boolean|nil, left: boolean|nil, right: boolean|nil, jump: boolean|nil, aux1: boolean|nil, sneak: boolean|nil, dig: boolean|nil, place: boolean|nil, LMB: boolean|nil, RMB: boolean|nil, zoom: boolean|nil }|nil
function PlayerObjectRef:get_player_control() end

---* Returns integer with bit packed player pressed keys.
---* Bits:
---  * 0 - up
---  * 1 - down
---  * 2 - left
---  * 3 - right
---  * 4 - jump
---  * 5 - aux1
---  * 6 - sneak
---  * 7 - dig
---  * 8 - place
---  * 9 - zoom
---* Returns `0` (no bits set) if the object is not a player.
---@return number|nil
function PlayerObjectRef:get_player_control_bits() end

--- * Note: All numeric fields modify a corresponding `movement_*` setting in the game's `core.conf`.
--- * Note: Some of the fields don't exist in old API versions, see feature
--- `physics_overrides_v2`.
---@class lt.PhysicsOverride
--- multiplier to *all* movement speed (`speed_*`) and
--- acceleration (`acceleration_*`) values (default: `1`)
---@field speed number|nil
--- multiplier to default walk speed value (default: `1`)
--- * Note: The actual walk speed is the product of `speed` and `speed_walk`
---@field speed_walk number|nil
--- * Default: `1`.
--- * Multiplier to default climb speed value.
--- * Note: The actual climb speed is the product of `speed` and `speed_climb`.
---@field speed_climb number|nil
--- * Default: `1`.
--- * Multiplier to default sneak speed value.
--- * Note: The actual sneak speed is the product of `speed` and `speed_crouch`.
---@field speed_crouch number|nil Default: `1`. Whether player can sneak.
--- multiplier to default speed value in Fast Mode (default: `1`)
--- * Note: The actual fast speed is the product of `speed` and `speed_fast`
---@field speed_fast number|nil
---@field jump number|nil Default: `1`. Multiplier to default jump value.
---@field gravity number|nil Default: `1`. Multiplier to default gravity value.
--- * Default: `1`.
--- * Multiplier to liquid movement resistance value
--- (for nodes with `liquid_move_physics`); the higher this value, the lower the
--- resistance to movement. At `math.huge`, the resistance is zero and you can
--- move through any liquid like air. (default: `1`)
---   * Warning: Values below 1 are currently unsupported.
---@field liquid_fluidity number|nil
--- * Default: `1`.
--- * Multiplier to default maximum liquid resistance value
--- (for nodes with `liquid_move_physics`); controls deceleration when entering
--- node at high speed. At higher values you come to a halt more quickly.
---@field liquid_fluidity_smooth number|nil
--- * Default: `1`.
--- * Multiplier to default liquid sinking speed value;
--- (for nodes with `liquid_move_physics`).
---@field liquid_sink number|nil
--- * Default: `1`.
--- * Multiplier to horizontal and vertical acceleration
--- on ground or when climbing.
---   * Note: The actual acceleration is the product of `speed` and `acceleration_default`.
---@field acceleration_default number|nil Default: `1`. Whether player can sneak.
--- * Default: `1`.
--- Multiplier to acceleration
--- when jumping or falling.
---   * Note: The actual acceleration is the product of `speed` and `acceleration_air`
---@field acceleration_air number|nil Default: `1`. Whether player can sneak.
--- Multiplier to acceleration in Fast Mode (default: `1`)
---    * Note: The actual acceleration is the product of `speed` and `acceleration_fast`
---@field acceleration_fast number|nil
---@field sneak boolean|nil Default: `true`. Whether player can sneak.
---@field sneak_glitch boolean|nil Default: `false`. Whether player can use the new move code replications of the old sneak side-effects: sneak ladders and 2 node sneak jump.
---@field new_move boolean|nil Default: `true`. Use new move/sneak code. When false the exact old code is used for the specific old sneak behavior.

--- * For games, we recommend for simpler code to first modify the `movement_*`
--- settings (e.g. via the game's `core.conf`) to set a global base value
--- for all players and only use `set_physics_override` when you need to change
--- from the base value on a per-player basis.
--- @param override_table lt.PhysicsOverride
function PlayerObjectRef:set_physics_override(override_table) end

---Returns the table given to `set_physics_override`.
---@return lt.PhysicsOverride|nil
function PlayerObjectRef:get_physics_override() end

---Add a HUD element described by HUD def, returns ID number on success.
---@param definition lt.HUDDef
---@return number id On success.
function PlayerObjectRef:hud_add(definition) end

---Remove the HUD element of the specified id.
---@param id number
function PlayerObjectRef:hud_remove(id) end

---* Change a value of a previously added HUD element.
---* `stat` supports the same keys as in the hud definition table except for
---  `"hud_elem_type"`.
---@param id number
---@param stat '"position"'|'"name"'|'"scale"'|'"text"'|'"number"'|'"item"'|'"dir"'
---@param value any
function PlayerObjectRef:hud_change(id, stat, value) end

---Gets the HUD element definition structure of the specified ID.
---@param id number
---@return lt.HUDElement
function PlayerObjectRef:hud_get(id) end

--- A mod should keep track of its introduced IDs and only use this to access foreign elements.
---   * It is discouraged to change foreign HUD elements.
---@return table<number, lt.HUDDef> # a table in the form `{ [id] = HUD definition, [id] = ... }`
function PlayerObjectRef:hud_get_all() end

---@class lt.HUDFlags
---@field hotbar boolean|nil
---@field healthbar boolean|nil
---@field crosshair boolean|nil
---@field wielditem boolean|nil
---@field breathbar boolean|nil
---@field minimap boolean|nil The client may locally elect to not view the minimap.
---@field minimap_radar boolean|nil Is only usable when `minimap` is true.
--- * Allow showing basic debug info that might give a gameplay advantage.
--- * This includes map seed, player position, look direction, the pointed node
--- * and block bounds. Does not affect players with the `debug` privilege.
---@field basic_debug boolean|nil
--- * Modifies the client's permission to view chat on the HUD.
--- * The client may locally elect to not view chat. Does not affect the console.
---@field chat boolean|nil

---Sets specified HUD flags of player.
---@param flags lt.HUDFlags If a flag equals `nil`, the flag is not modified.
function PlayerObjectRef:hud_set_flags(flags) end

---`hud_get_flags()`: returns a table of player HUD flags with boolean values.
---@return lt.HUDFlags
function PlayerObjectRef:hud_get_flags() end

---Sets number of items in builtin hotbar.
---@param count number Must be between `1` and `32`.
function PlayerObjectRef:hud_set_hotbar_itemcount(count) end

---Returns number of visible items.
---@return number
function PlayerObjectRef:hud_get_hotbar_itemcount() end

---Sets background image for hotbar.
---@param texturename string
function PlayerObjectRef:hud_set_hotbar_image(texturename) end

---Returns texturename.
---@return string
function PlayerObjectRef:hud_get_hotbar_image() end

---Sets image for selected item of hotbar.
---@param texturename string
function PlayerObjectRef:hud_set_hotbar_selected_image(texturename) end

---Returns texturename
---@return string
function PlayerObjectRef:hud_get_hotbar_selected_image() end

---@class lt.MiniMapMode
---@field type '"off"'|'"surface"'|'"radar"'|'"texture"'|nil
---@field label string|nil
---@field size number|nil Side length or diameter in nodes.
---@field texture string|nil Name of the texture.
---@field scale number|nil Only for texture type.

---Overrides the available minimap modes (and toggle order), and changes the
---selected mode.
---@param modes lt.MiniMapMode[]
---@param selected_mode number Mode index to be selected after change (starting at 0).
function PlayerObjectRef:set_minimap_modes(modes, selected_mode) end

---* The presence of the function `set_sun`, `set_moon` or `set_stars` indicates
---  whether `set_sky` accepts this format. Check the legacy format otherwise.
---* Passing no arguments resets the sky to its default values.
---@param sky_parameters lt.SkyParameters|nil
---@overload fun(base_color: lt.ColorSpec|nil, type:string|nil, textures:table|nil, clouds:boolean|nil) **Deprecated**.
function PlayerObjectRef:set_sky(sky_parameters) end

---@class lt.SkyParameters
--- Default: `#ffffff`.
--- ColorSpec, meaning depends on `type`
---@field base_color lt.ColorSpec|nil
--- * Float, rotation angle of sun/moon orbit in degrees.
--- * By default, orbit is controlled by a client-side setting, and this field is not set.
--- * After a value is assigned, it can only be changed to another float value.
--- * Valid range [-60.0,60.0] (default: not set).
---@field body_orbit_tilt? number
--- * `"regular"`: Uses 0 textures, `base_color` ignored
--- * `"skybox"`: Uses 6 textures, `base_color` used as fog.
--- * `"plain"`: Uses 0 textures, `base_color` used as both fog and sky.
--- (default: `"regular"`).
---@field type "regular"|"skybox"|"plain"|nil
--- order: Y+ (top), Y- (bottom), X+ (east), X- (west), Z- (south), Z+ (north).
--- The top and bottom textures are oriented in-line with the east (X+) face (the top edge of the
--- bottom texture and the bottom edge of the top texture touch the east face).
--- Some top and bottom textures expect to be aligned with the north face and will need to be rotated
--- by -90 and 90 degrees, respectively, to fit the eastward orientation.
---@field textures table|nil
---@field clouds boolean|nil `true` Boolean for whether clouds appear.
---@field sky_color? lt.SkyColor
---@field fog? lt.Fog

  ---A table used in regular sky_parameters type only (alpha is ignored)
  ---@class lt.SkyColor
  ---Default: `#61b5f5`. For the top half of the sky during the day.
  ---@field day_sky lt.ColorSpec|nil
  ---Default: `#90d3f6`. For the bottom half of the sky during the day.
  ---@field day_horizon lt.ColorSpec|nil
  ---Default: `#b4bafa`. For the top half of the sky during dawn/sunset.
  ---@field dawn_sky lt.ColorSpec|nil
  ---Default: `#bac1f0`. For the bottom half of the sky during dawn/sunset.
  ---@field dawn_horizon lt.ColorSpec|nil
  ---Default: `#006bff`. For the top half of the sky during the night.
  ---@field night_sky lt.ColorSpec|nil
  ---Default: `#4090ff`. For the bottom half of the sky during the night.
  ---@field night_horizon lt.ColorSpec|nil
  ---Default: `#646464`. For when you're either indoors or underground.
  ---@field indoors lt.ColorSpec|nil
  ---Default: `#f47d1d`. Changes the fog tinting for the sun at sunrise and sunset.
  ---@field fog_sun_tint lt.ColorSpec|nil
  ---Default: `#7f99cc`. Changes the fog tinting for the moon at sunrise and sunset.
  ---@field fog_moon_tint lt.ColorSpec|nil
  ---Default: `"default"`. Changes which mode the directional fog.
  ---@field fog_tint_type `"custom"`|`"default"`|nil

  --- A table with optional fields.
  ---@class lt.Fog
  --- integer, set an upper bound for the client's viewing_range.
  --- Any value >= 0 sets the desired upper bound for viewing_range,
  --- disables range_all and prevents disabling fog (F3 key by default).
  --- Any value < 0 resets the behavior to being client-controlled.
  ---@field fog_distance? number
  --- Float, override the client's fog_start.
  --- Fraction of the visible distance at which fog starts to be rendered.
  --- Any value between [0.0, 0.99] set the fog_start as a fraction of the viewing_range.
  --- Any value < 0, resets the behavior to being client-controlled.
  --- Default: `-1`.
  ---@field fog_start? number
  ---@field fog_color? lt.ColorSpec Override the color of the fog.
  --- Unlike `base_color` above this will apply regardless of the skybox type.
  --- (default: `"#00000000"`, which means no override)

---* `as_table`: boolean that determines whether the deprecated version of this
---  function is being used.
---  * `true` returns a table containing sky parameters as defined in `set_sky(sky_parameters)`.
---  * Deprecated: `false` or `nil` returns base_color, type, table of textures,
---  clouds.
---@param as_table boolean|nil
---@return lt.ColorSpec|lt.SkyParameters, string|nil, string[]|nil, boolean|nil
function PlayerObjectRef:get_sky(as_table) end

---* Deprecated: Use `get_sky(as_table)` instead.
---* Returns a table with the `sky_color` parameters as in `set_sky`.
---@deprecated
---@return lt.SkyColor
function get_sky_color() end

---@class lt.SunParameters
---@field visible boolean|nil Default: `true`. Whether the sun is visible.
---@field texture string|nil Default: `"sun.png"`. A regular texture for the sun. Setting to `""` will re-enable the mesh sun. The texture appears non-rotated at sunrise and rotated 180 degrees (upside down) at sunset.
---@field tonemap string|nil Default: `"sun_tonemap.png"`. A 512x1 texture containing the tonemap for the sun
---@field sunrise string|nil Default: `"sunrisebg.png"`. A regular texture for the sunrise texture.
---@field sunrise_visible boolean|nil Default: `true`. Boolean for whether the sunrise texture is visible.
---@field scale number|nil Default: `1`. Overall size of the sun. For legacy reasons, the sun is bigger than the moon by a factor of about `1.57` for equal `scale` values.

---Passing no arguments resets the sun to its default values.
---@param sun_parameters lt.SunParameters|nil
function PlayerObjectRef:set_sun(sun_parameters) end

---Returns a table with the current sun parameters as in `set_sun`.
---@return lt.SunParameters|nil
function PlayerObjectRef:get_sun() end

---@class lt.MoonParameters
---@field visible boolean|nil Default: `true`. Whether the moon is visible.
---@field texture string|nil Default: `"moon.png"`. A regular texture for the moon. Setting to `""` will re-enable the mesh moon. The texture appears non-rotated at sunrise / moonset and rotated 180 degrees (upside down) at sunset / moonrise. Note: Relative to the sun, the moon texture is hence rotated by 180°. You can use the `^[transformR180` texture modifier to achieve the same orientation.
---@field tonemap string|nil Default: `"moon_tonemap.png"`. A 512x1 texture containing the tonemap for the moon.
---@field scale number|nil Default: `1`. Controlling the overall size of the moon. Note: For legacy reasons, the sun is bigger than the moon by a factor of about `1.57` for equal `scale` values.

---Passing no arguments resets the moon to its default values.
---@param moon_parameters lt.MoonParameters
function PlayerObjectRef:set_moon(moon_parameters) end

---Returns a table with the current moon parameters as in `set_moon`.
---@return lt.MoonParameters|nil
function PlayerObjectRef:get_moon() end

---@class lt.StarParameters
---@field visible boolean|nil Default: `true`. Whether the stars are visible.
---@field day_opacity number|nil Default: `0.0`. Maximum opacity of stars at day (maximum: 1.0; minimum: 0.0). No effect if `visible` is false.
---@field count integer|nil Default: `1000`. Set the number of stars in the skybox. Only applies to `"skybox"` and `"regular"` sky types.
---@field star_color lt.ColorSpec|nil Default: `#ebebff69`. Sets the colors of the stars, alpha channel is used to set overall star brightness.
---@field scale number|nil Default: `1`. Controlling the overall size of the stars.

---Passing no arguments resets stars to their default values.
---@param star_parameters lt.StarParameters
function PlayerObjectRef:set_stars(star_parameters) end

---Returns a table with the current stars parameters as in `set_stars`.
---@return lt.StarParameters|nil
function PlayerObjectRef:get_stars() end

---@class lt.CloudParameters
---@field density number|nil Default: `0.4`. From `0` (no clouds) to `1` (full clouds).
---@field color lt.ColorSpec|nil Default: `#fff0f0e5`. Basic cloud color with alpha channel.
---@field ambient lt.ColorSpec|nil Default: `#000000`. Cloud color lower bound, use for a "glow at night" effect (alpha ignored).
---@field height number|nil Default: `120`. Cloud height, i.e. y of cloud base.
---@field thickness number|nil Default: `16`. Cloud thickness in nodes.
---@field speed {x:number, z:number}|nil Default: `{x=0, z=-2}`.

---Passing no arguments resets clouds to their default values.
---@param cloud_parameters lt.CloudParameters
function PlayerObjectRef:set_clouds(cloud_parameters) end

---Returns a table with the current cloud parameters as in `set_clouds`.
---@return lt.CloudParameters|nil
function PlayerObjectRef:get_clouds() end

---* Overrides day-night ratio, controlling sunlight to a specific amount.
---* Passing no arguments disables override, defaulting to sunlight based on day-night cycle.
---@param ratio? number Ratio from 0 to 1.
function PlayerObjectRef:override_day_night_ratio(ratio) end

---@return number|nil ratio Ratio from 0 to 1, or `nil` if not overridden.
function PlayerObjectRef:get_day_night_ratio() end

---* Set animation for player model in third person view.
---* Every animation equals to a `{x=starting frame, y=ending frame}`.
---@param idle {x:number, y:number}|nil
---@param walk {x:number, y:number}|nil
---@param dig  {x:number, y:number}|nil
---@param walk_while_dig {x:number, y:number}|nil
---@param frame_speed number|nil Default: `30`.
function PlayerObjectRef:set_local_animation(
  idle,
  walk,
  dig,
  walk_while_dig,
  frame_speed
)
end

---Returns idle, walk, dig, walk_while_dig tables and `frame_speed`.
---@return {x:number, y:number}|nil idle
---@return {x:number, y:number}|nil walk
---@return {x:number, y:number}|nil dig
---@return {x:number, y:number}|nil walk_while_dig
---@return number|nil frame_speed
function PlayerObjectRef:get_local_animation() end

---* Defines offset vectors for camera per player.
---* in third person view max values are `{x=-10/10, y=-10,15, z=-5/5}`
---@param firstperson? lt.Vector|nil * Offset in first person view. <br> * Defaults to `vector.zero()` if unspecified.
---@param thirdperson_back? lt.Vector|nil * Offset in third person back view. <br> * Clamped between `vector.new(-10, -10, -5)` and `vector.new(10, 15, 5)`. <br> * Defaults to `vector.zero()` if unspecified.
---@param thirdperson_front? lt.Vector|nil * Offset in third person front view. <br> * Same limits as for `thirdperson_back` apply. <br> * Defaults to `thirdperson_back` if unspecified.
function PlayerObjectRef:set_eye_offset(firstperson, thirdperson_back, thirdperson_front) end

---Returns first and third person offsets.
---@return lt.Vector|nil, lt.Vector|nil, lt.Vector|nil
function get_eye_offset() end

---* Sends an already loaded mapblock to the player.
---* Returns `false` if nothing was sent (note that this can also mean that
---      the client already has the block)
---* Resource intensive - use sparsely
---@param blockpos lt.Vector
---@return unknown|boolean result False if failed.
function PlayerObjectRef:send_mapblock(blockpos) end

---@class lt.Light
---@field saturation number|nil Default: `1.0`.
---@field shadows {intensity: number|nil}|nil This value has no effect on clients who have the "Dynamic Shadows" shader disabled.
--- A table that controls automatic exposure.
--- The basic exposure factor equation is `e = 2^exposure_correction / clamp(luminance, 2^luminance_min, 2^luminance_max)`.
--- * `luminance_min` set the lower luminance boundary to use in the calculation (default: `-3.0`).
--- * `luminance_max` set the upper luminance boundary to use in the calculation (default: `-3.0`).
--- * `exposure_correction` correct observed exposure by the given EV value (default: `0.0`).
--- * `speed_dark_bright` set the speed of adapting to bright light (default: `1000.0`).
--- * `speed_bright_dark` set the speed of adapting to dark scene (default: `1000.0`).
--- * `center_weight_power` set the power factor for center-weighted luminance measurement (default: `1.0`).
---@field exposure {luminance_min: number, luminance_max: number, exposure_correction: number, speed_dark_bright: number, speed_bright_dark: number, center_weight_power: number}
--- a table that controls volumetric light (a.k.a. "godrays")
--- * `strength`: sets the strength of the volumetric light effect from 0 (off, default) to 1 (strongest)
---    * This value has no effect on clients who have the "Volumetric Lighting" or "Bloom" shaders disabled.
---@field volumetric_light {strength: number}|nil

---Sets lighting for the player.
--- * Passing no arguments resets lighting to its default values.
---@param light_definition? lt.Light
function PlayerObjectRef:set_lighting(light_definition) end

---Returns the current state of lighting for the player.
---@return lt.Light|nil
function PlayerObjectRef:get_lighting() end

---Respawns the player using the same mechanism as the death screen,
---including calling `on_respawnplayer` callbacks.
function PlayerObjectRef:respawn() end

---@return lt.InvRef
function PlayerObjectRef:get_inventory() end
