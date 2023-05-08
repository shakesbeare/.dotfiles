return {
    'VonHeikemen/lsp-zero.nvim',
    event = "VeryLazy",
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },             -- Required
        { 'williamboman/mason.nvim' },           -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional
        { 'simrat39/rust-tools.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },     -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'hrsh7th/cmp-buffer' },   -- Optional
        { 'hrsh7th/cmp-path' },     -- Optional
        { 'hrsh7th/cmp-nvim-lua' }, -- Optional
        { 'hrsh7th/cmp-cmdline' },
        { 
            'L3MON4D3/LuaSnip',
            dependencies = {
                { 'rafamadriz/friendly-snippets' },
                { 'saadparwaiz1/cmp_luasnip' },
            },
            config = function(_, opts)
                require('luasnip.loaders.from_vscode').lazy_load()
            end
        },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        -- { 'hrsh7th/cmp-vsnip' },
        -- { 'hrsh7th/vim-vsnip' }, -- Required
        { 'jose-elias-alvarez/null-ls.nvim' },
    },
    config = function(_, opts)
        vim.diagnostic.config({ update_in_insert = true })

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        require("mason-lspconfig").setup {
            ensure_installed = { "rust_analyzer@nightly"}
        }

        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        require("mason-lspconfig").setup_handlers {
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function(server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup {
                    capabilities = capabilities
                }
            end,
            -- Next, you can provide a dedicated handler for specific servers.
            -- For example, a handler override for the `rust_analyzer`:
            ["lua_ls"] = function()
                require('lspconfig').lua_ls.setup {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim' }
                            }
                        }
                    }
                }
            end,

            ["rust_analyzer"] = function()
                require('rust-tools').setup {
                    server = {
                        capabilities = capabilities,
                        settings = {
                            ['rust-analyzer'] = {
                                checkOnSave = {
                                    allFeatures = true,
                                    overrideCommand = {
                                        'cargo', 'clippy', '--workspace', '--message-format=json',
                                        '--all-targets', '--all-features', '--', '-A', 'clippy::needless_return',
                                    }
                                },
                                completion = {
                                    postfix = {
                                        enable = false,
                                    }
                                },
                            }
                        }
                    },
                    dap = {
                        adapter = {
                            type = "executable",
                            command = "lldb-vscode-14",
                            name = "rt_lldb"
                        }
                    }
                }
            end,

        }


        -- Set up nvim-cmp.


        local feedkey = function(key, mode)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
        end

        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'nvim_lsp_signature_help' }
            }, {
                { name = 'buffer' },
            })
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
                { name = 'buffer' },
            })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })
    end
}
