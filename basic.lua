local function nnoremap(key, command)
	vim.api.nvim_set_keymap("n", key, command, { noremap = true })
end

local function xnoremap(key, command)
	vim.api.nvim_set_keymap("x", key, command, { noremap = true })
end

-- examples:
nnoremap("<C-h>", "^")
xnoremap("<C-h>", "^")

-- Buffers
nnoremap("<C-j>", ":bn<CR>")
nnoremap("<C-k>", ":bp<CR>")
