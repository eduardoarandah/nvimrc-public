-- update:
-- :PackerSync
-- :TSUpdate
-- :LspInstallInfo
require("settings")
require("mappings")
require("plugins")
require("syntax")
require("completion")
require("lsp")
local rtp = vim.opt.runtimepath:get()[1]
vim.cmd("source " .. rtp .. "/commands.vim")
