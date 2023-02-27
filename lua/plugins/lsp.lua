-- function to run once lsp is ready
local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local map = vim.keymap.set
	local cmd = vim.api.nvim_create_user_command
	local b = vim.lsp.buf
	local d = vim.diagnostic
	map("n", "<localleader>D", b.declaration)
	map("n", "<localleader>d", b.definition)
	map("n", "K", b.hover)
	map("n", "<localleader>i", b.implementation)
	map("n", "<localleader>k", b.signature_help)
	map("n", "<localleader>D", b.type_definition)
	map("n", "<localleader>r", b.rename)
	map("n", "<localleader>a", b.code_action)
	map("n", "<localleader>o", d.open_float)
	map("n", "[d", d.goto_prev)
	map("n", "]d", d.goto_next)
	cmd("LspFormat", function()
		vim.lsp.buf.format({ async = true })
	end, { bang = true })
	cmd("LspReferences", b.references, { bang = true })
	cmd("LspSetqflist", d.setqflist, { bang = true })
	cmd("LspWorkspaceAdd", b.add_workspace_folder, { bang = true })
	cmd("LspWorkspaceRemove", b.remove_workspace_folder, { bang = true })
	cmd("LspWorkspaceList", function()
		print(vim.inspect(b.list_workspace_folders()))
	end, { bang = true })
end

return {

	-- Automatically install LSPs
	{
		"williamboman/mason.nvim",
		config = true,
	},
	-- Integrate mason with lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		config = true,
	},

	-- Additional typescript support
	"jose-elias-alvarez/typescript.nvim",

	-- Useful status updates for LSP
	{ "j-hui/fidget.nvim", config = true },

	-- LSP configuration
	-- https://github.com/neovim/nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/typescript.nvim",
			"j-hui/fidget.nvim",
		},

		config = function()
			-- now configure lspconfig https://github.com/neovim/nvim-lspconfig
			local lsp = require("lspconfig")
			lsp.cssls.setup({ on_attach = on_attach })
			lsp.eslint.setup({ on_attach = on_attach })
			lsp.html.setup({ on_attach = on_attach })
			lsp.intelephense.setup({ on_attach = on_attach })
			lsp.jsonls.setup({ on_attach = on_attach })
			lsp.tailwindcss.setup({ on_attach = on_attach })
			lsp.tsserver.setup({ on_attach = on_attach })
			lsp.vimls.setup({ on_attach = on_attach })
			-- lsp.vuels.setup({ on_attach = on_attach })
			lsp.volar.setup({ on_attach = on_attach })
			lsp.yamlls.setup({ on_attach = on_attach })
			lsp.bashls.setup({ on_attach = on_attach })
			lsp.pylsp.setup({ on_attach = on_attach })
			lsp.lua_ls.setup({
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- Get the language server to recognize the `vim` global
						},
					},
				},
			})

			-- typescript
			-- https://github.com/jose-elias-alvarez/typescript.nvim
			require("typescript").setup({
				server = { -- pass options to lspconfig's setup method
					on_attach = on_attach,
				},
			})
		end,
	},
}