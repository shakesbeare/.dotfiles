vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.g.mapleader = " "

vim.opt.formatoptions = "lqj"
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
vim.opt.sidescrolloff = 88
vim.opt.splitbelow = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.swapfile = false
vim.opt.guicursor = ""
vim.opt.laststatus = 3

local homedir = os.getenv("HOME") or "C:/Users/berin"
vim.opt.undodir = homedir .. "/.undodir"
vim.opt.undofile = true

if vim.fn.has("win32") == 1 then
    vim.opt.shell = "powershell"
end

-- vim.opt.colorcolumn = "88"

vim.opt.wrap = false

-- term colors
vim.g.terminal_color_0 = '#0C0C0C'
vim.g.terminal_color_1 = '#C50F1F'
vim.g.terminal_color_2 = '#13A10E'
vim.g.terminal_color_3 = '#C19C00'
vim.g.terminal_color_4 = '#0037DA'
vim.g.terminal_color_1 = '#881798'
vim.g.terminal_color_1 = '#3A96DD'
vim.g.terminal_color_1 = '#CCCCCC'

vim.g.terminal_color_1 = '#767676'
vim.g.terminal_color_1 = '#E74856'
vim.g.terminal_color_1 = '#16C60C'
vim.g.terminal_color_1 = '#F9F1A5'
vim.g.terminal_color_1 = '#3B78FF'
vim.g.terminal_color_1 = '#B4009E'
vim.g.terminal_color_1 = '#61D6D6'
vim.g.terminal_color_1 = '#F2F2F2'
