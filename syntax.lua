-- treesitter enable
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"javascript",
		"json",
		"css",
		"php",
		"html",
		"python",
		"bash",
		"regex",
		"ruby",
		"yaml",
		"jsonc",
		"tsx",
		"lua",
		"vue",
	}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true,
		-- disable = { "php" }, -- list of language that will be disabled
	},
	indent = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
	},
})
