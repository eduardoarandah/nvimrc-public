return {
	-- emmet
	{
		"mattn/emmet-vim",
		ft = { "html", "php", "blade", "jsx", "tsx", "vue", "css", "scss" },
		config = function()
			vim.keymap.set("i", ",,", "<plug>(emmet-expand-abbr)", { remap = true })
		end,
	},

	-- prettify
	{
		"prettier/vim-prettier",
		ft = { "html", "php", "blade", "jsx", "vue", "css", "scss", "typescript", "json", "markdown", "yaml" },
		cmd = { "Prettier", "PrettierAsync" },
		build = "npm install",
	},

}
