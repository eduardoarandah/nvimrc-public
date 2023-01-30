return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (always install "c", "lua", "vim", "help")
				ensure_installed = {
					"bash",
					"c",
					"css",
					"help",
					"html",
					"javascript",
					"json",
					"jsonc",
					"lua",
					"lua",
					"php",
					"python",
					"regex",
					"ruby",
					"tsx",
					"typescript",
					"vim",
					"vue",
					"yaml",
				},
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
