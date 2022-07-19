-- update:
-- :PackerSync
-- :TSUpdate
-- :LspInstallInfo
require("settings")
require("mappings")
require("commands")
require("plugins")
require("syntax")
require("completion")
require("lsp")
vim.cmd("source " .. vim.fn.stdpath("config") .. "/commands.vim")
