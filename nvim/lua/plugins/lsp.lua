return {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' }, -- Required
        { 'williamboman/mason.nvim' }, -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional
        { 'simrat39/rust-tools.nvim', ft = "rs" },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp', event = "InsertEnter" }, -- Required
        { 'hrsh7th/cmp-nvim-lsp', event = "InsertEnter" }, -- Required
        { 'hrsh7th/cmp-buffer', event = "InsertEnter"  }, -- Optional
        { 'hrsh7th/cmp-path', event = "InsertEnter"  }, -- Optional
        { 'hrsh7th/cmp-nvim-lua', event = "InsertEnter"  }, -- Optional
        { 'hrsh7th/cmp-cmdline', event = "CmdLineEnter" },
        { 'hrsh7th/cmp-vsnip', event = "InsertEnter" },
        { 'hrsh7th/cmp-nvim-lsp-signature-help'},
        { 'hrsh7th/vim-vsnip', event = "InsertEnter" }, -- Required
        { 'jose-elias-alvarez/null-ls.nvim', event = "BufReadPre" }
    },
    config = function(_, opts)

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

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

            ["rust_analyzer"] = function()
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

            ["omnisharp"] = function()
                require('omnisharp').setup {
                    cmd = { "mono", "/Users/bmoffett/.omnisharp/Omnisharp.exe" },
                    capabilities = capabilities,
                }
            end,
        }

        local nvim_lsp = require('lspconfig')

        -- Set up nvim-cmp.

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local feedkey = function(key, mode)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
        end

        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    else
                        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' }, -- For vsnip users.
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
