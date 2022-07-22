-- LSP installer
-- Neovim plugin that allows you to seamlessly install LSP servers locally
-- :LspInstallInfo - opens a graphical overview of your language servers
-- https://github.com/williamboman/nvim-lsp-installer

require("nvim-lsp-installer").setup({
	ensure_installed = {
		"cssls",
		"eslint",
		"intelephense",
		"jsonls",
		"tailwindcss",
		"tsserver",
		"vimls",
		"vuels",
		"yamlls",
		"sumneko_lua",
		"html",
		"emmet_ls",
	},
})

-- LSP config
-- https://github.com/neovim/nvim-lspconfig
-- See also :help lspconfig.

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
	cmd("LspFormat", b.formatting, { bang = true })
	cmd("LspReferences", b.references, { bang = true })
	cmd("LspSetqflist", d.setqflist, { bang = true })
	cmd("LspWorkspaceAdd", b.add_workspace_folder, { bang = true })
	cmd("LspWorkspaceRemove", b.remove_workspace_folder, { bang = true })
	cmd("LspWorkspaceList", function()
		print(vim.inspect(b.list_workspace_folders()))
	end, { bang = true })
end

local lsp = require("lspconfig")
lsp.cssls.setup({ on_attach = on_attach })
lsp.eslint.setup({ on_attach = on_attach })
lsp.html.setup({ on_attach = on_attach })
lsp.intelephense.setup({ on_attach = on_attach })
lsp.jsonls.setup({ on_attach = on_attach })
lsp.tailwindcss.setup({ on_attach = on_attach })
lsp.tsserver.setup({ on_attach = on_attach })
lsp.vimls.setup({ on_attach = on_attach })
lsp.vuels.setup({ on_attach = on_attach })
lsp.yamlls.setup({ on_attach = on_attach })
lsp.emmet_ls.setup({ on_attach = on_attach })
lsp.sumneko_lua.setup({
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
