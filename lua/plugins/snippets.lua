-----------
-- snippets
-----------
local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command
return {

	-- Snippets luasnip
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip").config.setup({
				update_events = "TextChanged,TextChangedI", -- change on every keystroke
			})
			-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders
			require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets/snipmate" } })
			-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
			require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets/luasnip" } })

			-- commands
			cmd("SnipEdit", function()
				require("luasnip.loaders").edit_snippet_files()
			end, { bang = true })

			-- jump on snippet positions
			map({ "s", "i" }, "<C-j>", function()
				local l = require("luasnip")
				if l.jumpable() then
					l.jump(1)
				end
			end)

			map({ "s", "i" }, "<C-k>", function()
				local l = require("luasnip")
				if l.jumpable() then
					l.jump(-1)
				end
			end)
		end,
	},
	-- {
	-- 	"saadparwaiz1/cmp_luasnip",
	-- 	dependencies = {
	-- 		"L3MON4D3/LuaSnip",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	-- },
}
