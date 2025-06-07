---@meta
---Translations
---------------

--- `core.get_translator(textdomain)` is a simple wrapper around
--- `core.translate` and `core.translate_n`.
--- After `local S, PS = core.get_translator(textdomain)`, we have
--- `S(str, ...)` equivalent to `core.translate(textdomain, str, ...)`, and
--- `PS(str, str_plural, n, ...)` to `core.translate_n(textdomain, str, str_plural, n, ...)`.
--- It is intended to be used in the following way, so that it avoids verbose
--- repetitions of `core.translate`:
---
--- ```lua
--- local S, PS = core.get_translator(textdomain)
--- S(str, ...)
--- ```
---@param textdomain string
---@return mt.Translator, mt.Translator
---@nodiscard
function core.get_translator(textdomain) end

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
--   `core.translate`, but is in translation files to avoid being confused with
--   the `=` separating the original from the translation.
-- - `@\n` (where the `\n` is a literal newline) acts as a literal newline. As with
--   `@=`, this escape is not required in strings given to `core.translate`,
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
-- local S = core.get_translator("hello")
-- core.register_on_joinplayer(function(player)
--     local name = player:get_player_name()
--     core.chat_send_player(name, S("Hello @1, how are you today?", name))
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

--- Translates the string `str` with
--- the given `textdomain` for disambiguation. The textdomain must match the
--- textdomain specified in the translation file in order to get the string
--- translated. This can be used so that a string is translated differently in
--- different contexts.
--- It is advised to use the name of the mod as textdomain whenever possible, to
--- avoid clashes with other mods.
--- This function must be given a number of arguments equal to the number of
--- arguments the translated string expects.
--- Arguments are literal strings -- they will not be translated.
---@param textdomain string
---@param str string
---@param ... string
---@return string
---@nodiscard
function core.translate(textdomain, str, ...) end

--- ranslates the
--- string `str` with the given `textdomain` for disambiguaion. The value of
--- `n`, which must be a nonnegative integer, is used to decide whether to use
--- the singular or the plural version of the string. Depending on the locale of
--- the client, the choice between singular and plural might be more complicated,
--- but the choice will be done automatically using the value of `n`.
---
--- You can read https://www.gnu.org/software/gettext/manual/html_node/Plural-forms.html
--- for more details on the differences of plurals between languages.
---
--- Also note that plurals are only handled in .po or .mo files, and not in .tr files.
---@param textdomain string
---@param str string
---@param str_plural string
---@param n integer
---@param ... string
---@return string
---@nodiscard
function core.translate_n(textdomain, str, str_plural, n, ...) end

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

`core.get_translated_string(lang_code, string)`: Resolves translations in
the given string just like the client would, using the translation files for
`lang_code`. For this to have any effect, the string needs to contain translation
markup, e.g. `core.get_translated_string("fr", S("Hello"))`.

The `lang_code` to use for a given player can be retrieved from the table
returned by `core.get_player_information(name)`.

IMPORTANT: This functionality should only be used for sorting, filtering or
similar purposes. You do not need to use this to get translated strings to show
up on the client.
]]
---@param lang_code mt.LangCode
---@param string string
---@return string
---@nodiscard
function core.get_translated_string(lang_code, string) end
