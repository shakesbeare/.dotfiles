vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end



-- unbind annoying stuff
vim.keymap.set('n', "Q", "<nop>", { noremap = true })

-- HARPOON 
vim.keymap.set('n', "<Space>a", function() require("harpoon.mark").add_file() end, {noremap = true, silent = true})
vim.keymap.set('n', "<Space>e", function() require("harpoon.ui").toggle_quick_menu() end, {noremap = true, silent = true})

vim.keymap.set('n', "<C-h>", function() require("harpoon.ui").nav_file(1) end, {noremap = true, silent = true})
vim.keymap.set('n', "<C-t>", function() require("harpoon.ui").nav_file(2) end, {noremap = true, silent = true})
vim.keymap.set('n', "<C-n>", function() require("harpoon.ui").nav_file(3) end, {noremap = true, silent = true})
vim.keymap.set('n', "<C-s>", function() require("harpoon.ui").nav_file(4) end, {noremap = true, silent = true})

-- makes v-block mode a bit better
vim.keymap.set('n', "<C-c>", "<Esc>", { noremap = true })
vim.keymap.set('v', "<C-c>", "<Esc>", {noremap = true})
vim.keymap.set('x', "<C-c>", "<Esc>", {noremap = true})
vim.keymap.set('i', "<C-c>", "<Esc>", {noremap = true})
vim.keymap.set('c', "<C-c>", "<Esc>", {noremap = true})
vim.keymap.set('s', "<C-c>", "<Esc>", {noremap = true})

-- move selection up and down
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv", {noremap = true, silent = true})
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv", {noremap = true, silent = true})

-- File navigation
vim.keymap.set('n', '<leader>pv',
    function()
        if vim.bo.filetype == 'oil' then
            require('oil').close()
        else
            require('oil').open()
        end
    end, { noremap = true }
)
vim.keymap.set('n', '<leader>pf', '<cmd>Telescope find_files<CR>', { noremap = true })
vim.keymap.set('n', '<C-p>', '<cmd>Telescope git_files<CR>', { noremap = true })

-- Undo tree
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { noremap = true })

-- Improved yank/delete/paste controls
vim.keymap.set('x', '<leader>p', '"_dP', {noremap = true}) -- paste over selection without ruining register

vim.keymap.set('n', '<leader>y', '"+y', { noremap = true })  -- yank to clipboard
vim.keymap.set('v', '<leader>y', '"+y', {noremap = true})  -- ... in visual mode
vim.keymap.set('n', '<leader>y', '"+y', {noremap = true})

vim.keymap.set('n', '<leader>d', '"_d', { noremap = true }) -- delete without ruining register
vim.keymap.set('v', '<leader>d', '"_d', {noremap = true})

-- **********************************************************************
-- LSP Controls
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, { noremap = true, silent = true })
vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, { noremap = true, silent = true })
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>f', function() require('conform').format({lsp_fallback='always'}) end, { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, silent, { noremap = true }
vim.keymap.set('n', '<leader>ca', function() require('actions-preview').code_actions() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>r', function() vim.lsp.buf.rename() end, { noremap = true, silent = true })
vim.keymap.set('i', '<C-k>', function() vim.lsp.buf.signature_help() end, { silent = true })

-- **********************************************************************

vim.keymap.set('n', '<leader>t', function() require("trouble").toggle("workspace_diagnostics") end, silent, { noremap = true })
vim.keymap.set('n', '<leader>lr', function() require("trouble").toggle("lsp_references") end, silent, { noremap = true })
vim.keymap.set('n', '<leader>ld', function() require("trouble").toggle("lsp_definitions") end, silent, { noremap = true })


-- accept copilot suggestion, if available
-- otherwise, expand luasnip snippet, if available
-- otherwise, expand cmp suggestion, if available
-- otherwise, insert tab/space
vim.keymap.set('i',
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
    { noremap = true, silent = true }
)

