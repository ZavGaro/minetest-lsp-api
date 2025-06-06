---@meta
---Translations
---------------

-- A simple wrapper around `minetest.translate`.
--
-- It is equivalent to `minetest.translate(textdomain, str, ...)`.
--
-- It is intended to be used in the following way, so that it avoids verbose
-- repetitions of `minetest.translate`:
--
-- ```lua
-- local S = minetest.get_translator(textdomain)
-- S(str, ...)
-- ```
---@param textdomain string
---@return mt.Translator
---@nodiscard
function minetest.get_translator(textdomain) end

-- Translates strings with the given `textdomain` for disambiguation.
--
-- Strings that need to be translated can contain several escapes,
-- preceded by `@`.
--
-- - `@@` acts as a literal `@`.
-- - `@n`, where `n` is a digit between 1 and 9, is an argument for the translated
--   string that will be inlined when translated. Due to how translations are
--   implemented, the original translation string **must** have its arguments in
--   increasing order, without gaps or repetitions, starting from 1.
-- - `@=` acts as a literal `=`. It is not required in strings given to
--   `minetest.translate`, but is in translation files to avoid being confused with
--   the `=` separating the original from the translation.
-- - `@\n` (where the `\n` is a literal newline) acts as a literal newline. As with
--   `@=`, this escape is not required in strings given to `minetest.translate`,
--   but is in translation files.
-- - `@n` acts as a literal newline as well.
--
-- The textdomain must match the
-- textdomain specified in the translation file in order to get the string
-- translated. This can be used so that a string is translated differently in
-- different contexts. It is advised to use the name of the mod as textdomain
-- whenever possible, to avoid clashes with other mods. This function must be
-- given a number of arguments equal to the number of arguments the translated
-- string expects. Arguments are literal strings -- they will not be translated.
--
-- For instance, suppose we want to greet players when they join. We can do the
-- following:
-- 
-- ```lua
-- local S = minetest.get_translator("hello")
-- minetest.register_on_joinplayer(function(player)
--     local name = player:get_player_name()
--     minetest.chat_send_player(name, S("Hello @1, how are you today?", name))
-- end)
-- ```
-- 
-- When someone called "CoolGuy" joins the game with an old client or a client
-- that does not have localization enabled, they will see `Hello CoolGuy, how are
-- you today?`
-- 
-- However, if we have for instance a translation file named `hello.de.tr`
-- containing the following:
-- 
--     # textdomain: hello
--     Hello @1, how are you today?=Hallo @1, wie geht es dir heute?
-- 
-- and CoolGuy has set a German locale, they will see `Hallo CoolGuy, wie geht es
-- dir heute?`
---@alias mt.Translator fun(...: string): string

---@param textdomain string
---@param ... string
---@return string
---@nodiscard
function minetest.translate(textdomain, ...) end

---@alias mt.LangCode
---| "be"
---| "bg"
---| "ca"
---| "cs"
---| "da"
---| "de"
---| "el"
---| "en"
---| "eo"
---| "es"
---| "et"
---| "eu"
---| "fi"
---| "fr"
---| "gd"
---| "gl"
---| "hu"
---| "id"
---| "it"
---| "ja"
---| "jbo"
---| "kk"
---| "ko"
---| "lt"
---| "lv"
---| "ms"
---| "nb"
---| "nl"
---| "nn"
---| "pl"
---| "pt"
---| "pt_BR"
---| "ro"
---| "ru"
---| "sk"
---| "sl"
---| "sr_Cyrl"
---| "sr_Latn"
---| "sv"
---| "sw"
---| "tr"
---| "uk"
---| "vi"
---| "zh_CN"
---| "zh_TW"

--[[ **Server side translations**

On some specific cases, server translation could be useful. For example, filter
a list on labels and send results to client. A method is supplied to achieve
that:

`minetest.get_translated_string(lang_code, string)`: Resolves translations in
the given string just like the client would, using the translation files for
`lang_code`. For this to have any effect, the string needs to contain translation
markup, e.g. `minetest.get_translated_string("fr", S("Hello"))`.

The `lang_code` to use for a given player can be retrieved from the table
returned by `minetest.get_player_information(name)`.

IMPORTANT: This functionality should only be used for sorting, filtering or
similar purposes. You do not need to use this to get translated strings to show
up on the client.
]]
---@param lang_code mt.LangCode
---@param string string
---@return string
---@nodiscard
function minetest.get_translated_string(lang_code, string) end
