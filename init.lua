-- update:
-- :PackerSync
-- :TSUpdate
-- :LspInstallInfo
require("settings")
require("mappings")
require("commands")
require("plugins")
require("after_plugins")
require("syntax")
require("completion")
require("lsp")
local rtp = vim.fn.stdpath("config")
vim.cmd("source " .. rtp .. "/commands.vim")
