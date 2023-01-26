-- update:
-- :Lazy
-- :Mason
-- :TSUpdate
require("settings")
require("mappings")
require("commands")

-- bootstrap lazy.nvim, download if not exists
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load plugins in plugins folder
require("lazy").setup("plugins")

-- additional config for plugins
require("plugins_config")

-- more commands in vimscript
vim.cmd("source " .. vim.fn.stdpath("config") .. "/commands.vim")
