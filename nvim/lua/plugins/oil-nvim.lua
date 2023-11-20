return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function(_, _)
        require('oil').setup({
            delete_to_trash = true,
            columns = {
                "icon",
            },
            use_default_keymaps = false,
            keymaps = {
                ['-'] = "actions.parent",
                ['<CR>'] = "actions.select",
            },
            view_options = {
                show_hidden = true,
                sort = {
                    { "type", "asc" },
                    { "name", "asc" },
                },
                preview = {
                    max_width = 0.4,
                }
            },
        })
    end
}
