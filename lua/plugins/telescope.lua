local map = vim.keymap.set
local cmd = vim.api.nvim_create_user_command
return {
	-- Telescope fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					preview = {
						treesitter = false, -- treesitter freezes on big files
					},
				},
			})

			map("n", "<C-p>", ":Telescope find_files<CR>")
			map("n", "<C-f>", ":Telescope buffers<CR>")
			map("n", "<leader>hi", ":Telescope oldfiles<CR>")
			map("n", "<leader>:", ":Telescope command_history<CR>")
			map("n", "<leader>j", ":Telescope live_grep<CR>")
			map("n", "<leader>p", ":Telescope registers<CR>")
			map("n", "<leader><leader>", ":Telescope commands<CR>")
			map("n", "<localleader>s", ":Telescope lsp_document_symbols<CR>")
			map("n", "<localleader>g", ":Telescope live_grep<CR>")
			cmd("Options", ":Telescope vim_options", { bang = true })
			cmd("LiveGrep", ":Telescope live_grep", { bang = true })
			cmd("HelpTags", ":Telescope help_tags", { bang = true })
			cmd("ManPages", ":Telescope man_pages", { bang = true })
			cmd("Marks", ":Telescope marks", { bang = true })
			cmd("Registers", ":Telescope registers", { bang = true })

			-- git
			cmd("GBranch", ":Telescope git_branches", { bang = true }) -- Lists all branches with log preview, checkout action <cr>, track action <C-t> and rebase action<C-r>
			cmd("GBufferCommits", ":Telescope git_bcommits", { bang = true }) -- Lists buffer's git commits with diff preview and checks them out on <cr>

			-- lsp https://github.com/nvim-telescope/telescope.nvim#neovim-lsp-pickers
			cmd("References", ":Telescope lsp_references", { bang = true })
			cmd("Diagnostics", ":Telescope diagnostics", { bang = true })
			cmd("IncomingCalls", ":Telescope lsp_incoming_calls", { bang = true })
			cmd("OutgoingCalls", ":Telescope lsp_outgoing_calls", { bang = true })
			cmd("DocumentSymbols", ":Telescope lsp_document_symbols", { bang = true })
			cmd("WorkspaceSymbols", ":Telescope lsp_workspace_symbols", { bang = true })

			-- Focus on current dir for fuzzy finding
			cmd("FocusHere", function()
				-- get dir
				local current_dir = vim.fn.expand("%:h")

				-- remap fuzzy find
				vim.keymap.set("n", "<C-p>", function()
					require("telescope.builtin").find_files({
						cwd = current_dir,
					})
				end)
			end, { bang = true })
		end,
	},
}
