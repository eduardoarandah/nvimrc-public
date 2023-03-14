-----------------------------------------------------------------------------
-- nvim-cmp
-- A completion engine plugin for neovim written in Lua.
-- Completion sources are installed from external repositories and "sourced".
-- https://github.com/hrsh7th/nvim-cmp
-----------------------------------------------------------------------------

-- check: https://github.com/Wansmer/nvim-config/blob/main/lua/config/plugins/cmp.lua

return {
	{
		"hrsh7th/nvim-cmp",
		enabled = true,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's built-in language server client.
			"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words.
			"hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths.
			"hrsh7th/cmp-cmdline", -- nvim-cmp source for vim's cmdline.
			"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for neovim Lua API.
			"uga-rosa/cmp-dictionary", -- https://github.com/uga-rosa/cmp-dictionary
			"hrsh7th/cmp-nvim-lsp-document-symbol", -- nvim-cmp source for textDocument/documentSymbol via nvim-lsp.
			"hrsh7th/cmp-nvim-lsp-signature-help", -- nvim-cmp source for displaying function signatures with the current parameter emphasized:
		},
		config = function()
			local cmp = require("cmp")

			-- autopairs fix
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

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
					["<C-n>"] = next,
					["<down>"] = next,
					["<C-p>"] = prev,
					["<up>"] = prev,
					["<CR>"] = confirm_first,
					["<tab>"] = confirm_first,
					["<C-e>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-y>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "path" },
					{ name = "dictionary", keyword_length = 2 },
					{ name = "luasnip" },
					{ name = "nvim_lsp_signature_help" },
					{
						name = "buffer",
						option = {
							max_indexed_line_length = 50, -- prevent super long line to be indexed
						},
					},
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
			})

			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "nvim_lsp_document_symbol" },
				}, {
					{ name = "buffer" },
				}),
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
}
