-- update:
-- :Lazy
-- :Mason
-- :TSUpdate
require("settings")
require("mappings")
require("commands")
require("plugin_manager")
require("plugins_config")

-- more commands in vimscript
vim.cmd("source " .. vim.fn.stdpath("config") .. "/commands.vim")
