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

-- File navigation
nnoremap('<leader>pv', '<cmd>Ex<CR>')
nnoremap('<C-p>', '<cmd>Telescope find_files<CR>')


-- Comment toggle
nnoremap('<C-_>', '<cmd>CommentToggle<CR>')
vnoremap('<C-_>', '<cmd>CommentToggle<CR>')

nnoremap('<C-/>', '<cmd>CommentToggle<CR>')
vnoremap('<C-/>', '<cmd>CommentToggle<CR>')

-- Undo tree
nnoremap('<leader>u', '<cmd>UndotreeToggle<CR>')

-- Improved yank/delete/paste controls
xnoremap('<leader>p', '"_dP')  -- paste over selection without ruining register

nnoremap('<leader>y', '"+y') -- yank to clipboard
vnoremap('<leader>y', '"+y') -- ... in visual mode
nmap('<leader>y', '"+y')

nnoremap('<leader>d', '"_d')
vnoremap('<leader>d', '"_d')

-- Expand lsp message
nnoremap('gi', '<cmd>lua vim.diagnostic.open_float()<CR>')

-- Format document
nnoremap('<leader>gf', '<cmd>lua vim.lsp.buf.format()<CR>')

-- Hover action
nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')

inoremap('<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
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
