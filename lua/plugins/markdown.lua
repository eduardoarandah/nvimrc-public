return {
	-- Preview in browser
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_page_title = "${name}"
			vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/assets/markdown.css"
		end,
		ft = { "markdown" },
	},

	-- Table mode
	-- https://github.com/dhruvasagar/vim-table-mode
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown" },
		config = function()
			-- Bug: changing prefix doesn't work https://github.com/dhruvasagar/vim-table-mode/issues/222
			-- :h table-mode-mappings
			vim.g.table_mode_map_prefix = "<localleader>t"
			-- vim.cmd("let g:table_mode_map_prefix = '<localleader>t'")
			-- vim.g.toggle_mode_options_toggle_map = "<localleader>tm"
			-- vim.g.table_mode_commands_tableize = "<localleader>tt"

			-- For Markdown-compatible tables use
			vim.g.table_mode_corner = "|"
		end,
	},
}
