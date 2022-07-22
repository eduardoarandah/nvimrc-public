-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/lalo/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/lalo/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/lalo/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/lalo/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/lalo/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  HowMuch = {
    config = { "\27LJ\2\n´\2\0\0\6\0\14\0\0286\0\0\0009\0\1\0009\0\2\0006\1\0\0009\1\3\1)\2\b\0=\2\4\1\18\1\0\0'\3\5\0'\4\6\0'\5\a\0B\1\4\1\18\1\0\0'\3\b\0'\4\6\0'\5\t\0B\1\4\1\18\1\0\0'\3\b\0'\4\n\0'\5\v\0B\1\4\1\18\1\0\0'\3\b\0'\4\f\0'\5\r\0B\1\4\1K\0\1\0\26<Plug>AutoCalcReplace\16<leader>hmr%<Plug>AutoCalcAppendWithEqAndSum\16<leader>hms\31<Plug>AutoCalcAppendWithEq\6x V<Plug>AutoCalcAppendWithEq\15<leader>hm\6n\18HowMuch_scale\6g\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/HowMuch",
    url = "https://github.com/sk1418/HowMuch"
  },
  LuaSnip = {
    config = { "\27LJ\2\n?\0\0\3\1\2\0\n-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0009\0\1\0)\2\1\0B\0\2\1K\0\1\0\0¿\tjump\rjumpable?\0\0\3\1\2\0\n-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0009\0\1\0)\2ˇˇB\0\2\1K\0\1\0\0¿\tjump\rjumpableç\4\1\0\t\0\28\00016\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\0016\2\2\0009\2\5\0029\2\6\0029\3\a\0009\3\b\0035\5\t\0B\3\2\0016\3\0\0'\5\n\0B\3\2\0029\3\v\0035\5\r\0005\6\f\0=\6\14\5B\3\2\0016\3\0\0'\5\15\0B\3\2\0029\3\v\0035\5\17\0005\6\16\0=\6\14\5B\3\2\1\18\3\2\0'\5\18\0006\6\0\0'\b\19\0B\6\2\0029\6\20\0065\a\21\0B\3\4\1\18\3\1\0005\5\22\0'\6\23\0003\a\24\0B\3\4\1\18\3\1\0005\5\25\0'\6\26\0003\a\27\0B\3\4\0012\0\0ÄK\0\1\0\0\n<C-k>\1\3\0\0\6s\6i\0\n<C-j>\1\3\0\0\6s\6i\1\0\1\tbang\2\23edit_snippet_files\20luasnip.loaders\rSnipEdit\1\0\0\1\2\0\0\23./snippets/luasnip\29luasnip.loaders.from_lua\npaths\1\0\0\1\2\0\0\24./snippets/snipmate\14lazy_load\"luasnip.loaders.from_snipmate\1\0\1\18update_events\29TextChanged,TextChangedI\nsetup\vconfig\29nvim_create_user_command\bapi\bset\vkeymap\bvim\fluasnip\frequire\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["auto-pairs"] = {
    config = { "\27LJ\2\nY\0\0\2\0\5\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0K\0\1\0\19AutoPairsMapCh\5\28AutoPairsShortcutToggle\6g\bvim\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\nê\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\31auto_session_suppress_dirs\1\2\0\0\a~/\1\0\2\14log_level\tinfo\25auto_session_enabled\1\nsetup\17auto-session\frequire\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-dictionary"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/cmp-dictionary",
    url = "https://github.com/uga-rosa/cmp-dictionary"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["dracula.nvim"] = {
    config = { "\27LJ\2\nS\0\0\3\0\5\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0)\1\1\0=\1\4\0K\0\1\0\14rehash256\6g\24colorscheme dracula\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/dracula.nvim",
    url = "https://github.com/Mofiqul/dracula.nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nã\2\0\0\a\0\19\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\f\0005\3\4\0005\4\3\0=\4\5\0034\4\3\0005\5\6\0006\6\a\0009\6\b\0069\6\t\6=\6\n\5>\5\1\4=\4\v\3=\3\r\2B\0\2\0016\0\a\0009\0\14\0009\0\15\0\18\1\0\0'\3\16\0'\4\17\0'\5\18\0B\1\4\1K\0\1\0\23:LualineRenameTab \15<leader>tr\6n\bset\vkeymap\ftabline\1\0\0\14lualine_z\15max_length\fcolumns\6o\bvim\1\2\1\0\ttabs\tmode\3\2\14lualine_a\1\0\0\1\2\0\0\fbuffers\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n∂\1\0\0\6\0\v\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0\18\1\0\0'\3\6\0'\4\a\0'\5\b\0B\1\4\1\18\1\0\0'\3\6\0'\4\t\0'\5\n\0B\1\4\1K\0\1\0 :NvimTreeFindFileToggle<CR>\t<F8>\24:NvimTreeToggle<CR>\t<F7>\6n\bset\vkeymap\bvim\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["quickfix-reflector.vim"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/quickfix-reflector.vim",
    url = "https://github.com/stefandtw/quickfix-reflector.vim"
  },
  tabular = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n[\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\20grep_open_files\2\14live_grep\22telescope.builtin\frequire∆\t\1\0\b\0C\0}6\0\0\0009\0\1\0009\0\2\0006\1\0\0009\1\3\0019\1\4\0016\2\5\0'\4\6\0B\2\2\2\18\3\0\0'\5\a\0'\6\b\0009\a\t\2B\3\4\1\18\3\0\0'\5\a\0'\6\n\0009\a\v\2B\3\4\1\18\3\0\0'\5\a\0'\6\f\0009\a\r\2B\3\4\1\18\3\0\0'\5\a\0'\6\14\0009\a\15\2B\3\4\1\18\3\0\0'\5\a\0'\6\16\0003\a\17\0B\3\4\1\18\3\0\0'\5\a\0'\6\18\0009\a\19\2B\3\4\1\18\3\0\0'\5\a\0'\6\20\0009\a\21\2B\3\4\1\18\3\0\0'\5\a\0'\6\22\0009\a\23\2B\3\4\1\18\3\1\0'\5\24\0009\6\25\0025\a\26\0B\3\4\1\18\3\1\0'\5\27\0009\6\23\0025\a\28\0B\3\4\1\18\3\1\0'\5\29\0009\6\30\0025\a\31\0B\3\4\1\18\3\1\0'\5 \0009\6!\0025\a\"\0B\3\4\1\18\3\1\0'\5#\0009\6$\0025\a%\0B\3\4\1\18\3\1\0'\5&\0009\6'\0025\a(\0B\3\4\1\18\3\1\0'\5)\0009\6*\0025\a+\0B\3\4\1\18\3\1\0'\5,\0009\6-\0025\a.\0B\3\4\1\18\3\1\0'\5/\0009\0060\0025\a1\0B\3\4\1\18\3\1\0'\0052\0009\0063\0025\a4\0B\3\4\1\18\3\1\0'\0055\0009\0066\0025\a7\0B\3\4\1\18\3\1\0'\0058\0009\0069\0025\a:\0B\3\4\1\18\3\1\0'\5;\0009\6<\0025\a=\0B\3\4\1\18\3\1\0'\5>\0009\6\21\0025\a?\0B\3\4\1\18\3\1\0'\5@\0009\6A\0025\aB\0B\3\4\1K\0\1\0\1\0\1\tbang\2\26lsp_workspace_symbols\21WorkspaceSymbols\1\0\1\tbang\2\20DocumentSymbols\1\0\1\tbang\2\23lsp_outgoing_calls\18OutgoingCalls\1\0\1\tbang\2\23lsp_incoming_calls\18IncomingCalls\1\0\1\tbang\2\16diagnostics\16Diagnostics\1\0\1\tbang\2\19lsp_references\15References\1\0\1\tbang\2\15git_status\tDiff\1\0\1\tbang\2\17git_bcommits\18BufferCommits\1\0\1\tbang\2\16git_commits\fCommits\1\0\1\tbang\2\17git_branches\vBranch\1\0\1\tbang\2\nmarks\nMarks\1\0\1\tbang\2\14man_pages\rManPages\1\0\1\tbang\2\14help_tags\rHelpTags\1\0\1\tbang\2\rLiveGrep\1\0\1\tbang\2\16vim_options\fOptions\14live_grep\19<localleader>g\25lsp_document_symbols\19<localleader>s\rcommands\21<leader><leader>\0\14<leader>j\20command_history\14<leader>:\roldfiles\15<leader>hi\fbuffers\n<C-f>\15find_files\n<C-p>\6n\22telescope.builtin\frequire\29nvim_create_user_command\bapi\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["text-case.nvim"] = {
    config = { "\27LJ\2\né\2\0\0\6\0\14\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0'\2\1\0B\0\2\0016\0\5\0009\0\6\0009\0\a\0'\2\b\0'\3\t\0'\4\n\0005\5\v\0B\0\5\0016\0\5\0009\0\6\0009\0\a\0'\2\f\0'\3\t\0'\4\n\0005\5\r\0B\0\5\1K\0\1\0\1\0\1\tdesc\14Telescope\6v\1\0\1\tdesc\14Telescope#<cmd>TextCaseOpenTelescope<CR>\bga.\6n\20nvim_set_keymap\bapi\bvim\19load_extension\14telescope\nsetup\rtextcase\frequire\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/text-case.nvim",
    url = "https://github.com/johmsalas/text-case.nvim"
  },
  ["typescript.nvim"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/typescript.nvim",
    url = "https://github.com/jose-elias-alvarez/typescript.nvim"
  },
  ["vim-css-color"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/opt/vim-css-color",
    url = "https://github.com/ap/vim-css-color"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\2\n—\5\0\0\a\0\"\0H6\0\0\0009\0\1\0009\0\2\0006\1\0\0009\1\3\0019\1\4\1\18\2\0\0'\4\5\0'\5\6\0'\6\a\0B\2\4\1\18\2\0\0'\4\5\0'\5\b\0'\6\t\0B\2\4\1\18\2\0\0'\4\5\0'\5\n\0'\6\v\0B\2\4\1\18\2\0\0'\4\5\0'\5\f\0'\6\r\0B\2\4\1\18\2\0\0'\4\5\0'\5\14\0'\6\15\0B\2\4\1\18\2\0\0'\4\5\0'\5\16\0'\6\17\0B\2\4\1\18\2\0\0'\4\5\0'\5\18\0'\6\19\0B\2\4\1\18\2\0\0'\4\5\0'\5\20\0'\6\21\0B\2\4\1\18\2\0\0'\4\5\0'\5\22\0'\6\23\0B\2\4\1\18\2\0\0'\4\5\0'\5\24\0'\6\25\0B\2\4\1\18\2\0\0'\4\5\0'\5\26\0'\6\27\0B\2\4\1\18\2\1\0'\4\28\0'\5\29\0005\6\30\0B\2\4\1\18\2\1\0'\4\31\0'\5 \0005\6!\0B\2\4\1K\0\1\0\1\0\1\tbang\2\r:0Gclog!\17Ghistoryfile\1\0\1\tbang\2\v:Gclog\rGhistory\21:diffget //3<cr>\15<leader>ml\21:diffget //2<cr>\15<leader>mh\20:Gdiffsplit<cr>\15<leader>gd\18:Git push<cr>\15<leader>gp\28:Git checkout -b<space>\16<leader>gcb\25:Git checkout<space>\16<leader>gco\20:Git add -A<cr>\15<leader>gA\29:Git log --name-only<cr>\15<leader>gl\15:Gread<cr>\15<leader>gr\19:Git add %<cr>\15<leader>ga\29:tabnew | Git | only<cr>\15<leader>gs\6n\29nvim_create_user_command\bapi\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-lua-format"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/vim-lua-format",
    url = "https://github.com/andrejlevkovitch/vim-lua-format"
  },
  ["vim-maximizer"] = {
    config = { "\27LJ\2\nà\1\0\0\6\0\b\0\0146\0\0\0009\0\1\0009\0\2\0\18\1\0\0'\3\3\0'\4\4\0'\5\5\0B\1\4\1\18\1\0\0'\3\6\0'\4\4\0'\5\a\0B\1\4\1K\0\1\0\27:MaximizerToggle<CR>gv\6x\25:MaximizerToggle<CR>\14<leader>z\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/vim-maximizer",
    url = "https://github.com/szw/vim-maximizer"
  },
  ["vim-prettier"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/vim-prettier",
    url = "https://github.com/prettier/vim-prettier"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-ripgrep"] = {
    config = { "\27LJ\2\nZ\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0002rg --vimgrep --pcre2 --type-add=\"scss:*.scss\"\15rg_command\6g\bvim\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/vim-ripgrep",
    url = "https://github.com/jremmen/vim-ripgrep"
  },
  ["vim-signature"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/vim-signature",
    url = "https://github.com/kshenoy/vim-signature"
  },
  ["vim-slime"] = {
    config = { "\27LJ\2\nÃ\1\0\0\6\0\f\0\0226\0\0\0009\0\1\0009\0\2\0006\1\0\0009\1\3\1'\2\5\0=\2\4\0016\1\0\0009\1\3\1)\2\1\0=\2\6\1\18\1\0\0'\3\a\0'\4\b\0'\5\t\0B\1\4\1\18\1\0\0'\3\n\0'\4\b\0'\5\v\0B\1\4\1K\0\1\0\29<Plug>SlimeParagraphSend\6n\26<Plug>SlimeRegionSend\t<F9>\6x\22slime_no_mappings\ttmux\17slime_target\6g\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/vim-slime",
    url = "https://github.com/jpalardy/vim-slime"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/lalo/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: vim-slime
time([[Config for vim-slime]], true)
try_loadstring("\27LJ\2\nÃ\1\0\0\6\0\f\0\0226\0\0\0009\0\1\0009\0\2\0006\1\0\0009\1\3\1'\2\5\0=\2\4\0016\1\0\0009\1\3\1)\2\1\0=\2\6\1\18\1\0\0'\3\a\0'\4\b\0'\5\t\0B\1\4\1\18\1\0\0'\3\n\0'\4\b\0'\5\v\0B\1\4\1K\0\1\0\29<Plug>SlimeParagraphSend\6n\26<Plug>SlimeRegionSend\t<F9>\6x\22slime_no_mappings\ttmux\17slime_target\6g\bset\vkeymap\bvim\0", "config", "vim-slime")
time([[Config for vim-slime]], false)
-- Config for: auto-pairs
time([[Config for auto-pairs]], true)
try_loadstring("\27LJ\2\nY\0\0\2\0\5\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0K\0\1\0\19AutoPairsMapCh\5\28AutoPairsShortcutToggle\6g\bvim\0", "config", "auto-pairs")
time([[Config for auto-pairs]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nã\2\0\0\a\0\19\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\f\0005\3\4\0005\4\3\0=\4\5\0034\4\3\0005\5\6\0006\6\a\0009\6\b\0069\6\t\6=\6\n\5>\5\1\4=\4\v\3=\3\r\2B\0\2\0016\0\a\0009\0\14\0009\0\15\0\18\1\0\0'\3\16\0'\4\17\0'\5\18\0B\1\4\1K\0\1\0\23:LualineRenameTab \15<leader>tr\6n\bset\vkeymap\ftabline\1\0\0\14lualine_z\15max_length\fcolumns\6o\bvim\1\2\1\0\ttabs\tmode\3\2\14lualine_a\1\0\0\1\2\0\0\fbuffers\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\nê\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\31auto_session_suppress_dirs\1\2\0\0\a~/\1\0\2\14log_level\tinfo\25auto_session_enabled\1\nsetup\17auto-session\frequire\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: vim-ripgrep
time([[Config for vim-ripgrep]], true)
try_loadstring("\27LJ\2\nZ\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0002rg --vimgrep --pcre2 --type-add=\"scss:*.scss\"\15rg_command\6g\bvim\0", "config", "vim-ripgrep")
time([[Config for vim-ripgrep]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: dracula.nvim
time([[Config for dracula.nvim]], true)
try_loadstring("\27LJ\2\nS\0\0\3\0\5\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0)\1\1\0=\1\4\0K\0\1\0\14rehash256\6g\24colorscheme dracula\bcmd\bvim\0", "config", "dracula.nvim")
time([[Config for dracula.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n[\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\20grep_open_files\2\14live_grep\22telescope.builtin\frequire∆\t\1\0\b\0C\0}6\0\0\0009\0\1\0009\0\2\0006\1\0\0009\1\3\0019\1\4\0016\2\5\0'\4\6\0B\2\2\2\18\3\0\0'\5\a\0'\6\b\0009\a\t\2B\3\4\1\18\3\0\0'\5\a\0'\6\n\0009\a\v\2B\3\4\1\18\3\0\0'\5\a\0'\6\f\0009\a\r\2B\3\4\1\18\3\0\0'\5\a\0'\6\14\0009\a\15\2B\3\4\1\18\3\0\0'\5\a\0'\6\16\0003\a\17\0B\3\4\1\18\3\0\0'\5\a\0'\6\18\0009\a\19\2B\3\4\1\18\3\0\0'\5\a\0'\6\20\0009\a\21\2B\3\4\1\18\3\0\0'\5\a\0'\6\22\0009\a\23\2B\3\4\1\18\3\1\0'\5\24\0009\6\25\0025\a\26\0B\3\4\1\18\3\1\0'\5\27\0009\6\23\0025\a\28\0B\3\4\1\18\3\1\0'\5\29\0009\6\30\0025\a\31\0B\3\4\1\18\3\1\0'\5 \0009\6!\0025\a\"\0B\3\4\1\18\3\1\0'\5#\0009\6$\0025\a%\0B\3\4\1\18\3\1\0'\5&\0009\6'\0025\a(\0B\3\4\1\18\3\1\0'\5)\0009\6*\0025\a+\0B\3\4\1\18\3\1\0'\5,\0009\6-\0025\a.\0B\3\4\1\18\3\1\0'\5/\0009\0060\0025\a1\0B\3\4\1\18\3\1\0'\0052\0009\0063\0025\a4\0B\3\4\1\18\3\1\0'\0055\0009\0066\0025\a7\0B\3\4\1\18\3\1\0'\0058\0009\0069\0025\a:\0B\3\4\1\18\3\1\0'\5;\0009\6<\0025\a=\0B\3\4\1\18\3\1\0'\5>\0009\6\21\0025\a?\0B\3\4\1\18\3\1\0'\5@\0009\6A\0025\aB\0B\3\4\1K\0\1\0\1\0\1\tbang\2\26lsp_workspace_symbols\21WorkspaceSymbols\1\0\1\tbang\2\20DocumentSymbols\1\0\1\tbang\2\23lsp_outgoing_calls\18OutgoingCalls\1\0\1\tbang\2\23lsp_incoming_calls\18IncomingCalls\1\0\1\tbang\2\16diagnostics\16Diagnostics\1\0\1\tbang\2\19lsp_references\15References\1\0\1\tbang\2\15git_status\tDiff\1\0\1\tbang\2\17git_bcommits\18BufferCommits\1\0\1\tbang\2\16git_commits\fCommits\1\0\1\tbang\2\17git_branches\vBranch\1\0\1\tbang\2\nmarks\nMarks\1\0\1\tbang\2\14man_pages\rManPages\1\0\1\tbang\2\14help_tags\rHelpTags\1\0\1\tbang\2\rLiveGrep\1\0\1\tbang\2\16vim_options\fOptions\14live_grep\19<localleader>g\25lsp_document_symbols\19<localleader>s\rcommands\21<leader><leader>\0\14<leader>j\20command_history\14<leader>:\roldfiles\15<leader>hi\fbuffers\n<C-f>\15find_files\n<C-p>\6n\22telescope.builtin\frequire\29nvim_create_user_command\bapi\bset\vkeymap\bvim\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: vim-maximizer
time([[Config for vim-maximizer]], true)
try_loadstring("\27LJ\2\nà\1\0\0\6\0\b\0\0146\0\0\0009\0\1\0009\0\2\0\18\1\0\0'\3\3\0'\4\4\0'\5\5\0B\1\4\1\18\1\0\0'\3\6\0'\4\4\0'\5\a\0B\1\4\1K\0\1\0\27:MaximizerToggle<CR>gv\6x\25:MaximizerToggle<CR>\14<leader>z\6n\bset\vkeymap\bvim\0", "config", "vim-maximizer")
time([[Config for vim-maximizer]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
try_loadstring("\27LJ\2\n—\5\0\0\a\0\"\0H6\0\0\0009\0\1\0009\0\2\0006\1\0\0009\1\3\0019\1\4\1\18\2\0\0'\4\5\0'\5\6\0'\6\a\0B\2\4\1\18\2\0\0'\4\5\0'\5\b\0'\6\t\0B\2\4\1\18\2\0\0'\4\5\0'\5\n\0'\6\v\0B\2\4\1\18\2\0\0'\4\5\0'\5\f\0'\6\r\0B\2\4\1\18\2\0\0'\4\5\0'\5\14\0'\6\15\0B\2\4\1\18\2\0\0'\4\5\0'\5\16\0'\6\17\0B\2\4\1\18\2\0\0'\4\5\0'\5\18\0'\6\19\0B\2\4\1\18\2\0\0'\4\5\0'\5\20\0'\6\21\0B\2\4\1\18\2\0\0'\4\5\0'\5\22\0'\6\23\0B\2\4\1\18\2\0\0'\4\5\0'\5\24\0'\6\25\0B\2\4\1\18\2\0\0'\4\5\0'\5\26\0'\6\27\0B\2\4\1\18\2\1\0'\4\28\0'\5\29\0005\6\30\0B\2\4\1\18\2\1\0'\4\31\0'\5 \0005\6!\0B\2\4\1K\0\1\0\1\0\1\tbang\2\r:0Gclog!\17Ghistoryfile\1\0\1\tbang\2\v:Gclog\rGhistory\21:diffget //3<cr>\15<leader>ml\21:diffget //2<cr>\15<leader>mh\20:Gdiffsplit<cr>\15<leader>gd\18:Git push<cr>\15<leader>gp\28:Git checkout -b<space>\16<leader>gcb\25:Git checkout<space>\16<leader>gco\20:Git add -A<cr>\15<leader>gA\29:Git log --name-only<cr>\15<leader>gl\15:Gread<cr>\15<leader>gr\19:Git add %<cr>\15<leader>ga\29:tabnew | Git | only<cr>\15<leader>gs\6n\29nvim_create_user_command\bapi\bset\vkeymap\bvim\0", "config", "vim-fugitive")
time([[Config for vim-fugitive]], false)
-- Config for: text-case.nvim
time([[Config for text-case.nvim]], true)
try_loadstring("\27LJ\2\né\2\0\0\6\0\14\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0'\2\1\0B\0\2\0016\0\5\0009\0\6\0009\0\a\0'\2\b\0'\3\t\0'\4\n\0005\5\v\0B\0\5\0016\0\5\0009\0\6\0009\0\a\0'\2\f\0'\3\t\0'\4\n\0005\5\r\0B\0\5\1K\0\1\0\1\0\1\tdesc\14Telescope\6v\1\0\1\tdesc\14Telescope#<cmd>TextCaseOpenTelescope<CR>\bga.\6n\20nvim_set_keymap\bapi\bvim\19load_extension\14telescope\nsetup\rtextcase\frequire\0", "config", "text-case.nvim")
time([[Config for text-case.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n∂\1\0\0\6\0\v\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0\18\1\0\0'\3\6\0'\4\a\0'\5\b\0B\1\4\1\18\1\0\0'\3\6\0'\4\t\0'\5\n\0B\1\4\1K\0\1\0 :NvimTreeFindFileToggle<CR>\t<F8>\24:NvimTreeToggle<CR>\t<F7>\6n\bset\vkeymap\bvim\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\n?\0\0\3\1\2\0\n-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0009\0\1\0)\2\1\0B\0\2\1K\0\1\0\0¿\tjump\rjumpable?\0\0\3\1\2\0\n-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0009\0\1\0)\2ˇˇB\0\2\1K\0\1\0\0¿\tjump\rjumpableç\4\1\0\t\0\28\00016\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\0016\2\2\0009\2\5\0029\2\6\0029\3\a\0009\3\b\0035\5\t\0B\3\2\0016\3\0\0'\5\n\0B\3\2\0029\3\v\0035\5\r\0005\6\f\0=\6\14\5B\3\2\0016\3\0\0'\5\15\0B\3\2\0029\3\v\0035\5\17\0005\6\16\0=\6\14\5B\3\2\1\18\3\2\0'\5\18\0006\6\0\0'\b\19\0B\6\2\0029\6\20\0065\a\21\0B\3\4\1\18\3\1\0005\5\22\0'\6\23\0003\a\24\0B\3\4\1\18\3\1\0005\5\25\0'\6\26\0003\a\27\0B\3\4\0012\0\0ÄK\0\1\0\0\n<C-k>\1\3\0\0\6s\6i\0\n<C-j>\1\3\0\0\6s\6i\1\0\1\tbang\2\23edit_snippet_files\20luasnip.loaders\rSnipEdit\1\0\0\1\2\0\0\23./snippets/luasnip\29luasnip.loaders.from_lua\npaths\1\0\0\1\2\0\0\24./snippets/snipmate\14lazy_load\"luasnip.loaders.from_snipmate\1\0\1\18update_events\29TextChanged,TextChangedI\nsetup\vconfig\29nvim_create_user_command\bapi\bset\vkeymap\bvim\fluasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: HowMuch
time([[Config for HowMuch]], true)
try_loadstring("\27LJ\2\n´\2\0\0\6\0\14\0\0286\0\0\0009\0\1\0009\0\2\0006\1\0\0009\1\3\1)\2\b\0=\2\4\1\18\1\0\0'\3\5\0'\4\6\0'\5\a\0B\1\4\1\18\1\0\0'\3\b\0'\4\6\0'\5\t\0B\1\4\1\18\1\0\0'\3\b\0'\4\n\0'\5\v\0B\1\4\1\18\1\0\0'\3\b\0'\4\f\0'\5\r\0B\1\4\1K\0\1\0\26<Plug>AutoCalcReplace\16<leader>hmr%<Plug>AutoCalcAppendWithEqAndSum\16<leader>hms\31<Plug>AutoCalcAppendWithEq\6x V<Plug>AutoCalcAppendWithEq\15<leader>hm\6n\18HowMuch_scale\6g\bset\vkeymap\bvim\0", "config", "HowMuch")
time([[Config for HowMuch]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType css ++once lua require("packer.load")({'vim-css-color'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType scss ++once lua require("packer.load")({'vim-css-color'}, { ft = "scss" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
