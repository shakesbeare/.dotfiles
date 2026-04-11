vim.opt_local.textwidth = 9999999
vim.opt_local.wrap = true

-- move by visual line instead of actual line
vim.api.nvim_buf_set_keymap(0, "n", "j", "gj", { noremap = true, desc = "Move down by visual line" })
vim.api.nvim_buf_set_keymap(0, "n", "k", "gk", { noremap = true, desc = "Move up by visual line" })
vim.api.nvim_buf_set_keymap(0, "v", "j", "gj", { noremap = true, desc = "Move down by visual line" })
vim.api.nvim_buf_set_keymap(0, "v", "k", "gk", { noremap = true, desc = "Move up by visual line" })
