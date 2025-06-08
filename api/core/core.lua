---@meta

---Luanti 5.12 [7602b6](https://github.com/luanti-org/luanti/blob/7602b6/doc/lua_api.txt) API
---
---* [Official site](http://www.luanti.org)
---* [Developer Wiki](http://dev.luanti.org)
---* [Unofficial Modding Book](https://rubenwardy.com/minetest_modding_book)
---* [Modding tools](https://github.com/luanti-org/modtools)
---@class mt.Core
core = {
  CONTENT_AIR = 126,
  CONTENT_IGNORE = 127,
  CONTENT_UNKNOWN = 125,
  EMERGE_CANCELLED = 0,
  EMERGE_ERRORED = 1,
  EMERGE_FROM_DISK = 3,
  EMERGE_FROM_MEMORY = 2,
  EMERGE_GENERATED = 4,
  LIGHT_MAX = 14,
  MAP_BLOCKSIZE = 16,
  PLAYER_MAX_BREATH_DEFAULT = 10,
  PLAYER_MAX_HP_DEFAULT = 20,
}

---@type mt.Core
minetest = core