-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
    capabilities = capabilities
}
require('lspconfig')['sumneko_lua'].setup {
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
--require('lspconfig')['marksman'].setup {
--capabilities = capabilities
--}
require('lspconfig')['html'].setup {
    capabilities = capabilities
}
require('lspconfig')['tsserver'].setup {
    capabilities = capabilities,
}
require('lspconfig')['omnisharp'].setup {
    cmd = { "mono", "/Users/bmoffett/.omnisharp/Omnisharp.exe" },
    capabilities = capabilities,
}

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
