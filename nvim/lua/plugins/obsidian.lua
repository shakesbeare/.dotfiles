return {
    'epwalsh/obsidian.nvim',
    ft = "md",
    dependencies = {
        {'nvim-lua/plenary.nvim'}
    },
    config = function(_, opts)
        require('obsidian').setup {
            dir = "~/Dropbox/Documents/0-obsidian-notes",
            notes_subdir = "Notes",
            completion = {
                nvim_cmp = true,
            }
        }
    end
}
