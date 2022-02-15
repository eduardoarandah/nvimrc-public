-----------------------------------------------------------------------------
-- nvim-cmp
-- A completion engine plugin for neovim written in Lua.
-- Completion sources are installed from external repositories and "sourced".
-- https://github.com/hrsh7th/nvim-cmp
-----------------------------------------------------------------------------
local cmp = require("cmp")
local api = vim.api

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
		{ name = "ultisnips" },
		{ name = "nvim_lua" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "dictionary", keyword_length = 2 },
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

---------------------------------------------
-- dictionary
-- https://github.com/uga-rosa/cmp-dictionary
---------------------------------------------

require("cmp_dictionary").setup({
	dic = {},
	async = true,
	debug = false,
})

function DictBoostrap4()
	local dic = require("cmp_dictionary")
	-- Download boostrap and generate classes:
	-- curl -s https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.css | egrep '{' | egrep -o '\.[a-z0-9:-]+' | sed 's/\.//g' | sort -u > ~/.nvim/dict/bootstrap4
	dic.setup({ dic = { ["php,html,blade"] = { "~/.nvim/dict/bootstrap4" } } })
	dic.update()
end

api.nvim_command("command! DictBoostrap4 :lua DictBoostrap4()")

function DictTailwind()
	local dic = require("cmp_dictionary")
	-- mkdir -p ~/.nvim/dict
	-- https://tailwindcss.com/docs/installation#using-tailwind-without-post-css
	-- npx tailwindcss-cli@latest build -o ~/.nvim/dict/tailwind.css
	-- cat ~/.nvim/dict/tailwind.css | egrep '{' | egrep -o '\.[a-z0-9:-]+' | sed 's/\.//g' | sort -u > ~/.nvim/dict/tailwind
	dic.setup({ dic = { ["php,html,blade"] = { "~/.nvim/dict/tailwind" } } })
	dic.update()
end

api.nvim_command("command! DictTailwind :lua DictTailwind()")
