-- inspect tables easily
-- https://vonheikemen.github.io/devlog/es/tools/configuring-neovim-using-lua/
-- vim.keymap.set("n", "<F1>", 'yW:lua require"utils".wat(")<CR>') -- explore settings with F1
local function wat(key)
	print(vim.inspect(key))
end

return {
	wat = wat,
}
