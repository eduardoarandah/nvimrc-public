local function map(mode, key, command, opts)
	vim.api.nvim_set_keymap(mode, key, command, opts)
end

local function nnoremap(key, command)
	vim.api.nvim_set_keymap("n", key, command, { noremap = true })
end

local function xnoremap(key, command)
	vim.api.nvim_set_keymap("x", key, command, { noremap = true })
end

local function cnoremap(key, command)
	vim.api.nvim_set_keymap("c", key, command, { noremap = true })
end

local function onoremap(key, command)
	vim.api.nvim_set_keymap("o", key, command, { noremap = true })
end

-- inspect tables easily
-- https://vonheikemen.github.io/devlog/es/tools/configuring-neovim-using-lua/
-- nnoremap("<F1>", 'yW:lua require"utils".wat(")<CR>') -- explore settings with F1
local function wat(key)
	print(vim.inspect(key))
end

return {
	map = map,
	nnoremap = nnoremap,
	xnoremap = xnoremap,
	onoremap = onoremap,
	cnoremap = cnoremap,
	wat = wat,
}
