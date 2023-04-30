return {
    'mfussenegger/nvim-dap',
    dependencies = {
        { 
            'rcarriga/nvim-dap-ui',
             config = function(_, opts) 
                require('dapui').setup()
             end,
        },
        {
            'theHamsta/nvim-dap-virtual-text',
            config = function(_, opts)
                require('nvim-dap-virtual-text').setup()
            end
        },
        {
            'jay-babu/mason-nvim-dap.nvim',
            dependencies = { 'williamboman/mason.nvim' },
            config = function(_, opts) 
                require('mason-nvim-dap').setup()
            end
        }
    },
    event = "VeryLazy"
}
