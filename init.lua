require("settings")
require("mappings")
require("plugins")
require("syntax")
require("completion")
require("lsp")
local runtimepath = vim.opt.runtimepath:get()[1]
vim.cmd("source " .. runtimepath .. "/commands.vim")
