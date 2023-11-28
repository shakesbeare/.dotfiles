return {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
        { 'nvim-lua/plenary.nvim' }
    },
    opts = {
        workspaces = {
            {
                name = "Notes",
                path = "~/Dropbox/Documents/0-obsidian-notes/",
            },
        },
        notes_subdir = "Notes",
        completion = {
            nvim_cmp = true,
        },
        mappings = {
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Toggle check-boxes.
            ["<leader>ch"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
        }
    },
}
