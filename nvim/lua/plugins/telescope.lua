return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        { 'nvim-lua/plenary.nvim' }
    },
    event = "BufReadPre",
    opts = {
        defaults = {
            mappings = {
                i = {
                    ["<C-y>"] = "select_default",
                    -- ["<CR>"] = actions.select_default,
                },
                n = {
                    ["<C-y>"] = "select_default"
                    -- ["<CR>"] = actions.select_default,
                }
            }
        }
    }
}
