local Remap = require('shakesbeare.keymap')

local nmap = Remap.nmap
local exprimap = Remap.exprimap
local exprsmap = Remap.exprimap
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap
local inoremap = Remap.inoremap
local cnoremap = Remap.cnoremap
local snoremap = Remap.snoremap

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
cnoremap("<C-c>", "<Esc>")
snoremap("<C-c>", "<Esc>")

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

nnoremap('<leader>y', '"+y')  -- yank to clipboard
vnoremap('<leader>y', '"+y')  -- ... in visual mode
nmap('<leader>y', '"+y')

nnoremap('<leader>d', '"_d') -- delete without ruining register
vnoremap('<leader>d', '"_d')

-- **********************************************************************
-- LSP Controls
nnoremap('gd', function() vim.lsp.buf.definition() end, silent)
nnoremap('gi', function() vim.lsp.buf.implementation() end, silent)
nnoremap('<leader>vd', function() vim.diagnostic.open_float() end, silent)
nnoremap('K', function() vim.lsp.buf.hover() end, silent)
nnoremap('<leader>f', function() require('conform').format({lsp_fallback='always'}) end, silent)
-- nnoremap('<leader>ca', function() vim.lsp.buf.code_action() end, silent)
nnoremap('<leader>ca', function() require('actions-preview').code_actions() end, silent)
nnoremap('<leader>r', function() vim.lsp.buf.rename() end, silent)
inoremap('<C-k>', function() vim.lsp.buf.signature_help() end, silent)

-- **********************************************************************

nnoremap('<leader>t', function() require("trouble").toggle("workspace_diagnostics") end, silent)
nnoremap('<leader>lr', function() require("trouble").toggle("lsp_references") end, silent)
nnoremap('<leader>ld', function() require("trouble").toggle("lsp_definitions") end, silent)


-- accept copilot suggestion, if available
-- otherwise, expand luasnip snippet, if available
-- otherwise, expand cmp suggestion, if available
-- otherwise, insert tab/space
inoremap(
    '<Tab>',
    function()
        if require('copilot.suggestion').is_visible() then
            require('copilot.suggestion').accept()
        elseif require('luasnip').expand_or_jumpable() then
            require('luasnip').expand_or_jump()
        elseif has_words_before() then
            require('cmp').confirm({ select = true })
        else
            if vim.o.expandtab then
                vim.api.nvim_feedkeys(string.rep(' ', vim.o.tabstop), 'i', true)
            else
				local key = vim.api.nvim_replace_termcodes('<C-v>009', true, false, true)
				vim.api.nvim_feedkeys(key, 'i', true)
            end
        end
    end,
    silent
)

