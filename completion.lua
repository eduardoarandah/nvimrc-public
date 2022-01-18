-----------------------------------------------------------------------------
-- nvim-cmp
-- A completion engine plugin for neovim written in Lua.
-- Completion sources are installed from external repositories and "sourced".
-- https://github.com/hrsh7th/nvim-cmp
-----------------------------------------------------------------------------
local cmp = require("cmp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		{ name = "ultisnips" }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "nvim_lua" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Setup lspconfig.
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp = require("lspconfig")

--  npm i -g vscode-langservers-extracted
lsp.cssls.setup({ capabilities = capabilities })
lsp.html.setup({ capabilities = capabilities })
lsp.jsonls.setup({ capabilities = capabilities })
lsp.eslint.setup({ capabilities = capabilities })

---  npm install -g typescript typescript-language-server eslint prettier
lsp.tsserver.setup({ capabilities = capabilities, })

---  npm install -g intelephense # directory composer.json or .git file
lsp.intelephense.setup({ capabilities = capabilities, })

--  npm install -g @tailwindcss/language-server
lsp.tailwindcss.setup({ capabilities = capabilities, })

-- npm install -g vls
lsp.vuels.setup({ capabilities = capabilities, })
