local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command
return {
	-- Git
	{
		"tpope/vim-fugitive",
		config = function()
			map("n", "<leader>gs", ":tabnew<cr>:Git<cr>:only<cr>")
			map("n", "<leader>ga", ":Git add %<cr>")
			map("n", "<leader>gr", ":Gread<cr>")
			map("n", "<leader>gl", ":Git log --name-only<cr>")
			map("n", "<leader>gA", ":Git add -A<cr>")
			map("n", "<leader>gco", ":Git checkout<space>")
			map("n", "<leader>gcb", ":Git checkout -b<space>")
			map("n", "<leader>gp", ":Git push<cr>")

			-- git diff (:Gdiffsplit! for merge conflicts)
			map("n", "<leader>gd", ":Gdiffsplit<cr>")

			-- git merge left-right
			map("n", "<leader>mh", ":diffget //2<cr>")
			map("n", "<leader>ml", ":diffget //3<cr>")

			-- All commits
			cmd("Ghistory", ":Gclog", { bang = true })

			-- Commits for current file
			cmd("Ghistoryfile", ":0Gclog!", { bang = true })
		end,
	},

	-- Git diffs
	"lewis6991/gitsigns.nvim",
}
