-- https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

local function camel(string)
	return require("textcase").api.to_camel_case(string)
end
local function upper(string)
	return require("textcase").api.to_upper_case(string)
end
local function snake(string)
	return require("textcase").api.to_snake_case(string)
end

return {
	-- hello
	s(
		"hello",
		fmt(
			[[
Write your name {1}

Camel: {2}
Upper: {3}
Snake: {4}
    ]],
			{
				i(1, "ed"),
				f(function(args)
					return camel(args[1][1])
				end, { 1 }),
				f(function(args)
					return upper(args[1][1])
				end, { 1 }),
				f(function(args)
					return snake(args[1][1])
				end, { 1 }),
			}
		)
	),

	-- branch
	s(
		"branch",
		f(function()
			return vim.fn.system({ "git", "branch" })
		end)
	),
	-- date
	s("date", {
		t("today's date is: "),
		f(function()
			return os.date("%Y-%m-%d")
		end),
	}),
}
