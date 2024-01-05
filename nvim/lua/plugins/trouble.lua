return {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    keys = {
        { '<leader>t',  function() require("trouble").toggle("workspace_diagnostics") end, { noremap = true, silent = true } },
        { '<leader>lr', function() require("trouble").toggle("lsp_references") end,        { noremap = true, silent = true } },
        { '<leader>ld', function() require("trouble").toggle("lsp_definitions") end,       { noremap = true, silent = true } },
    },
    opts = {}
}
