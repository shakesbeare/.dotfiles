return {
    'mfussenegger/nvim-dap',
    dependencies = {
        {
            'rcarriga/nvim-dap-ui',
             config = function(_, _)
                require('dapui').setup()
             end,
        },
        {
            'theHamsta/nvim-dap-virtual-text',
            config = function(_, _)
                require('nvim-dap-virtual-text').setup({})
            end
        },
        {
            'jay-babu/mason-nvim-dap.nvim',
            dependencies = { 'williamboman/mason.nvim' },
            config = function(_, _)
                require('mason-nvim-dap').setup()
            end
        }
    },
    event = "VeryLazy"
}
