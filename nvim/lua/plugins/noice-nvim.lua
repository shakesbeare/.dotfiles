return {
    "folke/noice.nvim",
    dependencies = {
        -- {
        --     "rcarriga/nvim-notify",
        --     config = function()
        --         require("notify").setup {
        --             stages = 'static',
        --         }
        --     end
        --
        -- },
        { "MunifTanjim/nui.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
    },
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,
            long_message_to_split = true, -- long messages will be sent to a split
        },
        views = {
            mini = {
                win_options = {
                    winblend = 0,
                }
            },
            cmdline = {
                position = {
                    row = "75%",
                    col = "0%",
                }
            },
        }
    }
}
