return {
	-- status line / tabs
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				tabline = {
					lualine_a = { "buffers" },
					lualine_z = {
						{
							"tabs",
							mode = 2,
							max_length = vim.o.columns, -- full width
						},
					},
				},
			})
		end,
	},
}
