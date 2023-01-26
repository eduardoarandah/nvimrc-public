return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
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
					"typescript",
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
		end,
	},

	-- syntax: blade https://github.com/jwalton512/vim-blade
	{
		"jwalton512/vim-blade",
		config = function()
			-- Define some single Blade directives. This variable is used for highlighting only.
			vim.g.blade_custom_directives = { "datetime", "javascript", "error" }

			-- Define pairs of Blade directives. This variable is used for highlighting and indentation.
			vim.g.blade_custom_directives_pairs = {
				markdown = "endmarkdown",
				cache = "endcache",
				error = "enderror",
			}
		end,
	},
}
