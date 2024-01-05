return {
    {
        'williamboman/mason.nvim',
        event = "VeryLazy",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        },
    },
    {
        'williamboman/mason-lspconfig.nvim',
        event = "VeryLazy",
        dependencies = {
            'hrsh7th/nvim-cmp',
            'neovim/nvim-lspconfig',
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                    }
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                ["lua_ls"] = function()
                    require('lspconfig').lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim' }
                                },
                                hint = {
                                    enable = true,
                                    arrayIndex = "Disable",
                                    paramName = "Disable",
                                }
                            }
                        }
                    }
                end,

                ["ruff_lsp"] = function()
                    require('lspconfig').ruff_lsp.setup {
                        capabilities = capabilities,
                        on_attach = function(client, _)
                            client.server_capabilities.hoverProvider = false
                        end,
                    }
                end,

                ["pylsp"] = function()
                    require('lspconfig').pylsp.setup {
                        capabilities = capabilities,
                        settings = {
                            pylsp = {
                                plugins = {
                                    pylsp_mypy = { enabled = true },
                                    pyflakes = { enabled = false },
                                    pycodestyle = { enabled = false },
                                    mccabe = { enabled = false },
                                }
                            }
                        }
                    }
                end
            }
        end
    },
}
