-----------------------------------------------------------------------------
-- nvim-cmp
-- A completion engine plugin for neovim written in Lua.
-- Completion sources are installed from external repositories and "sourced".
-- https://github.com/hrsh7th/nvim-cmp
-----------------------------------------------------------------------------

return {
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")

			-- fallback to be safe in case of plugins mappings  :h cmp-mapping
			local function next(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end
			local function prev(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end
			local function confirm_first(fallback)
				if cmp.visible() then
					cmp.confirm({ select = true })
				else
					fallback()
				end
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = {
					["<C-e>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-y>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<CR>"] = confirm_first,
					["<tab>"] = confirm_first,
					["<C-n>"] = next,
					["<down>"] = next,
					["<C-p>"] = prev,
					["<up>"] = prev,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "path" },
					{ name = "dictionary", keyword_length = 2 },
					{ name = "luasnip" },
					{
						name = "buffer",
						option = {
							max_indexed_line_length = 50, -- prevent super long line to be indexed
						},
					},
				}),
			})

			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
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
		end,
	},

	-- Completion sources
	{ "hrsh7th/cmp-nvim-lsp", dependencies = { "hrsh7th/nvim-cmp" } }, -- nvim-cmp source for neovim's built-in language server client.
	{ "hrsh7th/cmp-buffer", dependencies = { "hrsh7th/nvim-cmp" } }, -- nvim-cmp source for buffer words.
	{ "hrsh7th/cmp-path", dependencies = { "hrsh7th/nvim-cmp" } }, -- nvim-cmp source for filesystem paths.
	{ "hrsh7th/cmp-cmdline", dependencies = { "hrsh7th/nvim-cmp" } }, -- nvim-cmp source for vim's cmdline.
	{ "hrsh7th/cmp-nvim-lua", dependencies = { "hrsh7th/nvim-cmp" } }, -- nvim-cmp source for neovim Lua API.
	{ "uga-rosa/cmp-dictionary", dependencies = { "hrsh7th/nvim-cmp" } }, -- https://github.com/uga-rosa/cmp-dictionary
}
