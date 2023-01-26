return {
	-- file explorer
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
		config = function()
			require("nvim-tree").setup({})

			local map = vim.keymap.set
			map("n", "<F7>", ":NvimTreeToggle<CR>")
			map("n", "<F8>", ":NvimTreeFindFile<CR>")
			map("n", "<leader>cd", ":cd %:p:h | NvimTreeOpen<cr>")
		end,
	},
}
