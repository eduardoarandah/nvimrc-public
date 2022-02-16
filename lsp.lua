-- Neovim plugin that allows you to seamlessly install LSP servers locally
-- :LspInstallInfo - opens a graphical overview of your language servers
-- https://github.com/williamboman/nvim-lsp-installer
local lsp_installer = require("nvim-lsp-installer")
local on_attach = function(client, bufnr)
	local function map(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function set(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end
	set("omnifunc", "v:lua.vim.lsp.omnifunc")
	local opts = { noremap = true, silent = false }
	map("n", "<localleader>D", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	map("n", "<localleader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	map("n", "<localleader>i", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	map("n", "<localleader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	map("n", "<localleader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	map("n", "<localleader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	map("n", "<localleader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	map("n", "<localleader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	map("n", "<localleader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	map("n", "<localleader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	map("n", "<localleader>n", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	map("n", "<localleader>o", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	map("n", "<localleader>E", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	map("n", "<localleader>e", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	map("n", "<localleader>c", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	map("n", "<localleader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
	}
	server:setup(opts)
end)
