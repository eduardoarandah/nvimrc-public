-- Neovim plugin that allows you to seamlessly install LSP servers locally
-- :LspInstallInfo - opens a graphical overview of your language servers
-- https://github.com/williamboman/nvim-lsp-installer
--
local function nnoremap(key, command)
	vim.api.nvim_set_keymap("n", key, command, { noremap = true })
end

require("nvim-lsp-installer").on_server_ready(function(server)
	server:setup({
		on_attach = function(_, bufnr)
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			nnoremap("<localleader>D", ":lua vim.lsp.buf.declaration()<CR>")
			nnoremap("<localleader>d", ":lua vim.lsp.buf.definition()<CR>")
			nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
			nnoremap("<localleader>i", ":lua vim.lsp.buf.implementation()<CR>")
			nnoremap("<localleader>k", ":lua vim.lsp.buf.signature_help()<CR>")
			nnoremap("<localleader>wa", ":lua vim.lsp.buf.add_workspace_folder()<CR>")
			nnoremap("<localleader>wr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>")
			nnoremap("<localleader>wl", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
			nnoremap("<localleader>D", ":lua vim.lsp.buf.type_definition()<CR>")
			nnoremap("<localleader>r", ":lua vim.lsp.buf.rename()<CR>")
			nnoremap("<localleader>a", ":lua vim.lsp.buf.code_action()<CR>")
			nnoremap("<localleader>n", ":lua vim.lsp.buf.references()<CR>")
			nnoremap("<localleader>o", ":lua vim.diagnostic.open_float()<CR>")
			nnoremap("<localleader>E", ":lua vim.diagnostic.goto_prev()<CR>")
			nnoremap("<localleader>e", ":lua vim.diagnostic.goto_next()<CR>")
			nnoremap("<localleader>c", ":lua vim.diagnostic.setloclist()<CR>")
			nnoremap("<localleader>f", ":lua vim.lsp.buf.formatting()<CR>")
		end,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" }, -- Get the language server to recognize the `vim` global
				},
			},
		},
	})
end)
