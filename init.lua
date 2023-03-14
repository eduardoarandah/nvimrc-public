-- update:
-- :Lazy
-- :Mason
-- :TSUpdate
require("settings")
require("mappings")
require("commands")
require("plugin_manager")
require("per_project")

-- more commands in vimscript
vim.cmd("source " .. vim.fn.stdpath("config") .. "/commands.vim")
