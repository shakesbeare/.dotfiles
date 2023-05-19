vim.g.mapleader = ' '

vim.opt.guicursor = ""
vim.opt.showmatch = true
vim.opt.wildmenu = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.linebreak = true
vim.opt.conceallevel = 2
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.foldenable = false
vim.opt.syntax = "on"
vim.opt.smartindent = true
vim.opt.scrolloff = 8

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.swapfile = false

vim.opt.undodir = os.getenv("HOME") .. "/.undodir"
vim.opt.undofile = true

vim.opt.colorcolumn = "80"
vim.opt.cursorline = false

vim.opt.wrap = false
