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
			map("n", "<leader>gg", ":Git log --graph --all<cr>")
			map("n", "<leader>gA", ":Git add -A<cr>")
			map("n", "<leader>gco", ":Git checkout<space>")
			map("n", "<leader>gcb", ":Git checkout -b<space>")
			map("n", "<leader>gp", ":Git push<cr>")

			-- git diff (:Gdiffsplit! for merge conflicts)
			map("n", "<leader>gd", ":Gvdiffsplit! master<cr>")

			-- git merge left-right
			map("n", "<leader>mh", ":diffget //2<cr>")
			map("n", "<leader>ml", ":diffget //3<cr>")

			-- All commits
			cmd("Ghistory", ":Gclog", { bang = true })

			-- Commits for current file
			cmd("Ghfilehistory", ":0Gclog!", { bang = true })
		end,
	},
	{
		-- A git commit browser.
		-- https://github.com/junegunn/gv.vim
		--
		-- Commands
		-- :GV to open commit browser
		-- You can pass git log options to the command, e.g. :GV -S foobar -- plugins.
		-- :GV! will only list commits that affected the current file
		-- :GV? fills the location list with the revisions of the current file
		-- :GV or :GV? can be used in visual mode to track the changes in the selected lines.
		--
		-- Mappings
		-- o or <cr> on a commit to display the content of it
		-- o or <cr> on commits to display the diff in the range
		-- O opens a new tab instead
		-- gb for :GBrowse
		-- ]] and [[ to move between commits
		-- . to start command-line with :Git [CURSOR] SHA à la fugitive
		-- q or gq to close
		"junegunn/gv.vim",
	},
	-- Git diffs
	{ "lewis6991/gitsigns.nvim", config = true },
}
