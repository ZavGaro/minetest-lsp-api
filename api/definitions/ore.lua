---@meta
---Ore definition
-----------------

-- Used by `core.register_ore`.
---@class lt.OreDef
---@field ore_type lt.OreType
---@field ore string
---@field ore_param2 number Facedir rotation. Default is 0 (unchanged rotation).
---@field wherein string|string[]
-- Ore has a 1 out of `clust_scarcity` chance of spawning in a node.
-- If the desired average distance between ores is `d`, set this to
-- `d` * `d` * `d`.
---@field clust_scarcity number
---@field clust_num_ores number Number of ores in a cluster.
-- Size of the bounding box of the cluster.
-- In this example, there is a 3 * 3 * 3 cluster where 8 out of the 27
-- nodes are coal ore.
---@field clust_size number
---@field y_min number Lower limit for ore.
---@field y_max number Upper limit for ore.
---@field flags lt.OreFlags
-- If noise is above this threshold, ore is placed. Not needed for a
-- uniform distribution.
---@field noise_threshold number
---@field noise_params lt.NoiseParams
---@field biomes string[]
---@field column_height_min number "sheet" type only.
---@field column_height_max number "sheet" type only.
---@field column_midpoint_factor number "sheet" type only.
---@field np_puff_top lt.NoiseParams "puff" type only.
---@field np_puff_bottom lt.NoiseParams "puff" type only.
---@field random_factor number "vein" type only.
---@field np_stratum_thickness lt.NoiseParams "stratum" type only.
---@field stratum_thickness number "stratum" type only.

--[[
NoiseParams structure describing one of the noises used for ore distribution.

* Needed by "sheet", "puff", "blob" and "vein" ores.
* Omit from "scatter" ore for a uniform ore distribution.
* Omit from "stratum" ore for a simple horizontal strata from y_min to y_max.

Example for 2D or 3D perlin noise or perlin noise maps:

    np_terrain = {
        offset = 0,
        scale = 1,
        spread = {x = 500, y = 500, z = 500},
        seed = 571347,
        octaves = 5,
        persistence = 0.63,
        lacunarity = 2.0,
        flags = "defaults, absvalue",
    }

For 2D noise the Z component of `spread` is still defined but is ignored. A
single noise parameter table can be used for 2D or 3D noise.
]]
---@class lt.NoiseParams
--[[ After the multiplication by `scale` this is added to the result and is the
final step in creating the noise value. Can be positive or negative. ]]
---@field offset number
--[[ Once all octaves have been combined, the result is multiplied by this.
Can be positive or negative. ]]
---@field scale number
--[[
For octave1, this is roughly the change of input value needed for a very
large variation in the noise value generated by octave1. It is almost like a
`wavelength` for the wavy noise variation. Each additional octave has a
`wavelength` that is smaller than the previous octave, to create finer detail.
`spread` will therefore roughly be the typical size of the largest structures in
the final noise variation.

`spread` is a vector with values for x, y, z to allow the noise variation to be
stretched or compressed in the desired axes. Values are positive numbers.
]]
---@field spread lt.Vector
--[[
This is a whole number that determines the entire pattern of the noise
variation. Altering it enables different noise patterns to be created. With
other parameters equal, different seeds produce different noise patterns and
identical seeds produce identical noise patterns.

For this parameter you can randomly choose any whole number. Usually it is
preferable for this to be different from other seeds, but sometimes it is useful
to be able to create identical noise patterns.

In some noise APIs the world seed is added to the seed specified in noise
parameters. This is done to make the resulting noise pattern vary in different
worlds, and be 'world-specific'.
]]
---@field seed number
--[[
The number of simple noise generators that are combined. A whole number, 1 or
more. Each additional octave adds finer detail to the noise but also increases
the noise calculation load. 3 is a typical minimum for a high quality, complex
and natural-looking noise variation. 1 octave has a slight 'gridlike'
appearance.

Choose the number of octaves according to the `spread` and `lacunarity`, and the
size of the finest detail you require. For example: if `spread` is 512 nodes,
`lacunarity` is 2.0 and finest detail required is 16 nodes, octaves will be 6
because the 'wavelengths' of the octaves will be 512, 256, 128, 64, 32, 16
nodes. Warning: If the 'wavelength' of any octave falls below 1 an error will
occur.
]]
---@field octaves number
--[[
Each additional octave has an amplitude that is the amplitude of the previous
octave multiplied by `persistence`, to reduce the amplitude of finer details, as
is often helpful and natural to do so. Since this controls the balance of fine
detail to large-scale detail `persistence` can be thought of as the 'roughness'
of the noise.

A positive or negative non-zero number, often between 0.3 and 1.0. A common
medium value is 0.5, such that each octave has half the amplitude of the
previous octave. This may need to be tuned when altering `lacunarity`; when
doing so consider that a common medium value is 1 / lacunarity.

Instead of `persistence`, the key `persist` may be used to the same effect.
]]
---@field persistence number
--[[
Each additional octave has a 'wavelength' that is the 'wavelength' of the
previous octave multiplied by 1 / lacunarity, to create finer detail.
'lacunarity' is often 2.0 so 'wavelength' often halves per octave.

A positive number no smaller than 1.0. Values below 2.0 create higher quality
noise at the expense of requiring more octaves to cover a paticular range of
'wavelengths'.
]]
---@field lacunarity number
-- Leave this field unset for no special handling.
---@field flags nil|string
-- Specify this if you would like to keep auto-selection of eased/not-eased
-- while specifying some other flags.
---|"defaults"
-- Maps noise gradient values onto a quintic S-curve before performing
-- interpolation. This results in smooth, rolling noise. Disable this (`noeased`)
-- for sharp-looking noise with a slightly gridded appearance. If no flags are
-- specified (or defaults is), 2D noise is eased and 3D noise is not eased.
-- Easing a 3D noise significantly increases the noise calculation load,
-- so use with restraint.
---|"eased"
--The absolute value of each octave's noise variation is used when combining
-- the octaves. The final perlin noise variation is created as follows:
-- noise = offset + scale _ (abs(octave1) + abs(octave2) _ persistence +
-- abs(octave3) _ persistence ^ 2 + abs(octave4) _ persistence ^ 3 + ...)
---|"absvalue"

-- These tell in what manner the ore is generated.
--
-- All default ores are of the uniformly-distributed `scatter` type.
---@alias lt.OreType
-- Randomly chooses a location and generates a cluster of ore.
--
-- If `noise_params` is specified, the ore will be placed if the 3D perlin noise
-- at that point is greater than the `noise_threshold`, giving the ability to
-- create a non-equal distribution of ore.
---|"scatter"
-- Creates a sheet of ore in a blob shape according to the 2D perlin noise
-- described by `noise_params` and `noise_threshold`. This is essentially an
-- improved version of the so-called "stratus" ore seen in some unofficial mods.
--
-- This sheet consists of vertical columns of uniform randomly distributed height,
-- varying between the inclusive range `column_height_min` and `column_height_max`.
-- If `column_height_min` is not specified, this parameter defaults to 1.
-- If `column_height_max` is not specified, this parameter defaults to `clust_size`
-- for reverse compatibility. New code should prefer `column_height_max`.
--
-- The `column_midpoint_factor` parameter controls the position of the column at
-- which ore emanates from.
-- If 1, columns grow upward. If 0, columns grow downward. If 0.5, columns grow
-- equally starting from each direction.
-- `column_midpoint_factor` is a decimal number ranging in value from 0 to 1. If
-- this parameter is not specified, the default is 0.5.
--
-- The ore parameters `clust_scarcity` and `clust_num_ores` are ignored for this
-- ore type.
---|"sheet"
-- Creates a sheet of ore in a cloud-like puff shape.
--
-- As with the `sheet` ore type, the size and shape of puffs are described by
-- `noise_params` and `noise_threshold` and are placed at random vertical
-- positions within the currently generated chunk.
--
-- The vertical top and bottom displacement of each puff are determined by the
-- noise parameters `np_puff_top` and `np_puff_bottom`, respectively.
---|"puff"
-- Creates a deformed sphere of ore according to 3d perlin noise described by
-- `noise_params`. The maximum size of the blob is `clust_size`, and
-- `clust_scarcity` has the same meaning as with the `scatter` type.
---|"blob"
-- Creates veins of ore varying in density by according to the intersection of two
-- instances of 3d perlin noise with different seeds, both described by
-- `noise_params`.
--
-- `random_factor` varies the influence random chance has on placement of an ore
-- inside the vein, which is `1` by default. Note that modifying this parameter
-- may require adjusting `noise_threshold`.
--
-- The parameters `clust_scarcity`, `clust_num_ores`, and `clust_size` are ignored
-- by this ore type.
--
-- This ore type is difficult to control since it is sensitive to small changes.
-- The following is a decent set of parameters to work from:
--
--     noise_params = {
--         offset  = 0,
--         scale   = 3,
--         spread  = {x=200, y=200, z=200},
--         seed    = 5390,
--         octaves = 4,
--         persistence = 0.5,
--         lacunarity = 2.0,
--         flags = "eased",
--     },
--     noise_threshold = 1.6
--
-- **WARNING**: Use this ore type *very* sparingly since it is ~200x more
-- computationally expensive than any other ore.
---|"vein"
-- Creates a single undulating ore stratum that is continuous across mapchunk
-- borders and horizontally spans the world.
--
-- The 2D perlin noise described by `noise_params` defines the Y coordinate of
-- the stratum midpoint. The 2D perlin noise described by `np_stratum_thickness`
-- defines the stratum's vertical thickness (in units of nodes). Due to being
-- continuous across mapchunk borders the stratum's vertical thickness is
-- unlimited.
--
-- If the noise parameter `noise_params` is omitted the ore will occur from y_min
-- to y_max in a simple horizontal stratum.
--
-- A parameter `stratum_thickness` can be provided instead of the noise parameter
-- `np_stratum_thickness`, to create a constant thickness.
--
-- Leaving out one or both noise parameters makes the ore generation less
-- intensive, useful when adding multiple strata.
--
-- `y_min` and `y_max` define the limits of the ore generation and for performance
-- reasons should be set as close together as possible but without clipping the
-- stratum's Y variation.
--
-- Each node in the stratum has a 1-in-`clust_scarcity` chance of being ore, so a
-- solid-ore stratum would require a `clust_scarcity` of 1.
--
-- The parameters `clust_num_ores`, `clust_size`, `noise_threshold` and
-- `random_factor` are ignored by this ore type.
---|"stratum"

---@alias lt.OreFlagString
-- If set, puff ore generation will not taper down large differences in
-- displacement when approaching the edge of a puff. This flag has no effect for
-- ore types other than `puff`.
---|"puff_cliffs"
-- By default, when noise described by `np_puff_top` or `np_puff_bottom` results
-- in a negative displacement, the sub-column at that point is not generated. With
-- this attribute set, puff ore generation will instead generate the absolute
-- difference in noise displacement values. This flag has no effect for ore types
-- other than `puff`.
---|"puff_additive_composition"

---@alias lt.OreFlagsTable table<lt.OreFlagString|string, boolean>

---@alias lt.OreFlags lt.OreFlagString|lt.OreFlagsTable
