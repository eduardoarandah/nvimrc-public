-----------
-- snippets
-----------
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
		end,
	},
	{
		"saadparwaiz1/cmp_luasnip",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		},
	},
}
