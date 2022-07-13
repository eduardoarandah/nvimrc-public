local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command

-- LuaSnip
-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders
require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets/snipmate" } })
cmd("SnipEdit", require("luasnip.loaders").edit_snippet_files, { bang = true })

-- jump on snippet positions
local l = require("luasnip")
map({ "s", "i" }, "<C-j>", function()
	if l.jumpable() then
		l.jump(1)
	end
end)

map({ "s", "i" }, "<C-k>", function()
	if l.jumpable() then
		l.jump(-1)
	end
end)
