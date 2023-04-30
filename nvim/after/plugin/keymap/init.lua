local Remap = require('shakesbeare.keymap')

local nmap = Remap.nmap
local exprnmap = Remap.exprnmap
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap
local inoremap = Remap.inoremap

local silent = { silent = true }

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- unbind annoying stuff
nnoremap("q", "<nop>")
nnoremap("Q", "<nop>")

-- comment toggle
nnoremap("<leader>c", ":CommentToggle<CR>", silent)
vnoremap("<leader>c", ":CommentToggle<CR>", silent)

-- move selection up and down
vnoremap("J", ":m '>+1<CR>gv=gv", silent)
vnoremap("K", ":m '<-2<CR>gv=gv", silent)

-- File navigation
nnoremap('<leader>pv', '<cmd>Ex<CR>')
nnoremap('<leader>pf', '<cmd>Telescope find_files<CR>')
nnoremap('<C-p>', '<cmd>Telescope git_files<CR>')

-- Undo tree
nnoremap('<leader>u', '<cmd>UndotreeToggle<CR>')

-- Improved yank/delete/paste controls
xnoremap('<leader>p', '"_dP') -- paste over selection without ruining register

nnoremap('<leader>y', '"+y') -- yank to clipboard
vnoremap('<leader>y', '"+y') -- ... in visual mode
nmap('<leader>y', '"+y')

nnoremap('<leader>d', '"_d') -- delete without ruining register
vnoremap('<leader>d', '"_d')

-- **********************************************************************
-- LSP Controls
nnoremap('gd', function() vim.lsp.buf.definition() end, silent)
nnoremap('gi', function() vim.lsp.buf.implementation() end, silent)
nnoremap('<leader>vd', function() vim.diagnostic.open_float() end, silent)
nnoremap('K', function() vim.lsp.buf.hover() end, silent)
nnoremap('<leader>f', function() vim.lsp.buf.format() end, silent)
nnoremap('<leader>ca', function() vim.lsp.buf.code_action() end, silent)
nnoremap('<leader>r', function() vim.lsp.buf.rename() end, silent)
inoremap('<C-k>', function() vim.lsp.buf.signature_help() end, silent)

-- Debugger controls
dap = require('dap')
nnoremap('<F5>', function() dap.continue() end, silent)
nnoremap('<F1>', function() dap.step_over() end, silent)
nnoremap('<F2>', function() dap.step_into() end, silent)
nnoremap('<F3>', function() dap.step_out() end, silent)
nnoremap('<leader>b', function() dap.toggle_breakpoint() end, silent)
nnoremap('<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, silent)
nnoremap('<leader>dr', function() dap.repl.open() end, silent)

-- **********************************************************************

-- Tab completion
vim.cmd([[
    imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
]])

vim.cmd([[
    smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
]])

exprnmap(
    'gf',
    function()
        if require('obsidian').util.cursor_on_markdown_link() then
            return "<cmd>ObsidianFollowLink<CR>"
        else
            return "gf"
        end
    end,
    silent
)

