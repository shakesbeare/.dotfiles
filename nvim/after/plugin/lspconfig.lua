require("mason").setup {}
require("mason-lspconfig").setup {}

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            capabilities = capabilities
        }
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    
    ["rust_analyzer"] = function ()
        require('rust-tools').setup {
            server = {
                capabilities = capabilities,
                settings = {
                    ['rust-analyzer'] = {
                        completion = {
                            postfix = {
                                enable = false,
                            }
                        },
                    }
                }
            },
        }
    end,

    ["sumneko_lua"] = function()
       require('lspconfig').sumneko_lua.setup {
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' }
                    },
                    workspace = {
                        liberary = vim.api.nvim_get_runtime_file("", true)
                    },
                    telemetry = {
                        enable = false,
                    }
                }
            }
        }
    end,
    
    ["omnisharp"] = function()
        require('omnisharp').setup {
            cmd = { "mono", "/Users/bmoffett/.omnisharp/Omnisharp.exe" },
            capabilities = capabilities,
        }
    end,
}



