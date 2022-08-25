-- update:
-- :PackerSync
-- :TSUpdate
-- :LspInstallInfo
require("settings")
require("mappings")
require("commands")
require("plugins")
require("plugins_config")
vim.cmd("source " .. vim.fn.stdpath("config") .. "/commands.vim")
