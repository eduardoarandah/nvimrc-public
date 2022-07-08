local cmd = vim.api.nvim_create_user_command

cmd("Greport", require("greport").greport, { bang = true })
