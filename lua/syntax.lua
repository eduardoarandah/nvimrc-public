-- treesitter enable
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"css",
		"html",
		"javascript",
		"json",
		"jsonc",
		"lua",
		"php",
		"python",
		"regex",
		"ruby",
		"tsx",
		"vue",
		"yaml",
	}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
	},
})
