local Remap = require('shakesbeare.keymap')

local nmap = Remap.nmap
local exprnmap = Remap.exprnmap
local exprimap = Remap.exprimap
local exprsmap = Remap.exprimap
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap
local inoremap = Remap.inoremap

local silent = { silent = true }

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- unbind annoying stuff
nnoremap("Q", "<nop>")

-- makes v-block mode a bit better
nnoremap("<C-c>", "<Esc>")
vnoremap("<C-c>", "<Esc>")
xnoremap("<C-c>", "<Esc>")
inoremap("<C-c>", "<Esc>")

-- comment toggle
nnoremap("<leader>/", ":CommentToggle<CR>", silent)
vnoremap("<leader>/", ":CommentToggle<CR>", silent)

-- move selection up and down
vnoremap("J", ":m '>+1<CR>gv=gv", silent)
vnoremap("K", ":m '<-2<CR>gv=gv", silent)

-- File navigation
nnoremap('<leader>pv', 
    function() 
        if vim.bo.filetype == 'oil' then
            require('oil').close()
        else
            require('oil').open()
        end
    end
)
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

-- **********************************************************************

nnoremap('<leader>t',function() require("trouble").toggle("workspace_diagnostics") end, silent)
nnoremap('<leader>lr', function() require("trouble").toggle("lsp_references") end, silent)
nnoremap('<leader>ld', function() require("trouble").toggle("lsp_definitions") end, silent)

exprimap(
    '<Tab>',
    function()
        if require('luasnip').expand_or_jumpable() then
            require('luasnip').expand_or_jump()
            print("expanded or jumped")
        elseif has_words_before() then
            require('cmp').confirm({ select = true })
            print("confirmed")
        else
            return "<Tab>"
        end
    end,
    silent
)

exprsmap(
    '<Tab>',
    function()
        if require('luasnip').expand_or_jumpable() then
            require('luasnip').expand_or_jump()
            print("expanded or jumped")
        elseif has_words_before() then
            require('cmp').confirm({ select = true })
            print("confirmed")
        else
            return "<Tab>"
        end
    end,
    silent
)

