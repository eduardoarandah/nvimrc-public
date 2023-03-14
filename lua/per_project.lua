-- Haynet
vim.api.nvim_create_user_command("ProjHaynet", function()
	vim.cmd("nnoremap <leader>f :silent !npx eslint --fix % ; npx prettier --stdin-filepath %<CR>")
end, { bang = true })


