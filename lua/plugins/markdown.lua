return {
	-- Preview in browser
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/assets/markdown.css"
		end,
		ft = { "markdown" },
	},

	-- Table mode
	"dhruvasagar/vim-table-mode",
}
