-- update:
-- :Lazy
-- :Mason
-- :TSUpdate
require("settings")
require("mappings")
require("commands")
-- more commands in vimscript
vim.cmd("source " .. vim.fn.stdpath("config") .. "/commands.vim")
require("per_project")

------------------------------------------
-- Plugin manager
-- https://github.com/folke/lazy.nvim
------------------------------------------
-- download if not exists
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
