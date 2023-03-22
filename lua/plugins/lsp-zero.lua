-- Boilerplate for LSP and completion
-- https://github.com/VonHeikemen/lsp-zero.nvim
--
--Default keybindings
-- K: Displays hover information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.hover().
-- gd: Jumps to the definition of the symbol under the cursor. See :help vim.lsp.buf.definition().
-- gD: Jumps to the declaration of the symbol under the cursor. Some servers don't implement this feature. See :help vim.lsp.buf.declaration().
-- gi: Lists all the implementations for the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.implementation().
-- go: Jumps to the definition of the type of the symbol under the cursor. See :help vim.lsp.buf.type_definition().
-- gr: Lists all the references to the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.references().
-- <Ctrl-k>: Displays signature information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.signature_help(). If a mapping already exists for this key this function is not bound.
-- <F2>: Renames all references to the symbol under the cursor. See :help vim.lsp.buf.rename().
-- ga: Selects a code action available at the current cursor position. See :help vim.lsp.buf.code_action().
-- gl: Show diagnostics in a floating window. See :help vim.diagnostic.open_float().
-- [d: Move to the previous diagnostic in the current buffer. See :help vim.diagnostic.goto_prev().
-- ]d: Move to the next diagnostic. See :help vim.diagnostic.goto_next().
return {
  "VonHeikemen/lsp-zero.nvim",
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" }, -- Required
    { "williamboman/mason.nvim" }, -- Optional
    { "williamboman/mason-lspconfig.nvim" }, -- Optional

    -- Autocompletion
    { "hrsh7th/nvim-cmp" }, -- Required
    { "hrsh7th/cmp-nvim-lsp" }, -- Required
    { "hrsh7th/cmp-buffer" }, -- Optional
    { "hrsh7th/cmp-path" }, -- Optional
    { "saadparwaiz1/cmp_luasnip" }, -- Optional
    { "hrsh7th/cmp-nvim-lua" }, -- Optional

    -- Snippets
    { "L3MON4D3/LuaSnip" }, -- Required
    -- { "rafamadriz/friendly-snippets" }, -- Optional

    -- Additional typescript support
    "jose-elias-alvarez/typescript.nvim",

    -- Useful status updates for LSP
    { "j-hui/fidget.nvim", config = true },
  },
  config = function()
    local lsp = require("lsp-zero").preset({
      name = "minimal",
      set_lsp_keymaps = true,
      manage_nvim_cmp = true,
      suggest_lsp_servers = true,
    })

    -- custom: mappings
    -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v1.x/doc/md/autocomplete.md#override-keybindings
    local cmp = require("cmp")
    local function confirm_first(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end
    lsp.setup_nvim_cmp({
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = confirm_first,
        ["<tab>"] = confirm_first,
      }),
    })

    -- (Optional) Configure lua language server for neovim
    lsp.nvim_workspace()

    lsp.setup()

    -- Additional typescript support
    -- https://github.com/jose-elias-alvarez/typescript.nvim
    require("typescript").setup({})

    -- keymaps
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
  end,
}
