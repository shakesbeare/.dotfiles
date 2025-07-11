return {
    "folke/which-key.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
        preset = "helix",
        spec = {
            { "<leader>l", group="LSP Actions" },
            { "<leader>q", group="Code Formatting" },
        }
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
