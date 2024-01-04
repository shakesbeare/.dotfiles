return {
    'neovim/nvim-lspconfig',
    event = "BufReadPre",
    dependencies = {
        -- LSP Support
        { 'williamboman/mason.nvim' },           -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional
        -- DAP
        { 'mfussenegger/nvim-dap' },
        { 'jay-babu/mason-nvim-dap.nvim' },
        {
            'rcarriga/nvim-dap-ui',
            dependencies = {
                'mfussenegger/nvim-dap'
            }
        },
        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            config = function(_, _)
                require('cmp').setup {
                    mapping = require('cmp').mapping.preset.insert({
                        ['<C-n>'] = require('cmp').mapping.select_next_item(),
                        ['<C-p>'] = require('cmp').mapping.select_prev_item(),
                        ['<C-y>'] = require('cmp').mapping.confirm(),
                    }),
                }
            end,
        },                          -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'hrsh7th/cmp-buffer' },   -- Optional
        { 'hrsh7th/cmp-path' },     -- Optional
        { 'hrsh7th/cmp-nvim-lua' }, -- Optional
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        {
            'L3MON4D3/LuaSnip',
            dependencies = {
                { 'saadparwaiz1/cmp_luasnip' },
            },
            config = function(_, _)
                require('luasnip.loaders.from_vscode').lazy_load()
            end
        },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        -- formatting without language servers
        {
            'stevearc/conform.nvim',
            opts = {
                formatters_by_ft = {
                    rust = { 'leptosfmt' },
                    gdscript = { 'gdformat' },
                    gd = { 'gdformat' }
                },
                -- format_on_save = {}
                formatters = {
                    leptosfmt = {
                        command = 'leptosfmt',
                        args = {
                            '--quiet',
                            '--stdin',
                        },
                        stdin = true
                    },
                    gdformat = {
                        command = 'gdformat',
                        args = {
                            '--line-length', '88',
                            '-'
                        }
                    },
                    stdin = true,
                }
            },
        },
    },
    config = function(_, _)
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })
        require("mason-lspconfig").setup {}
        require("mason-nvim-dap").setup {}

        local dap = require('dap')
        local dapui = require('dapui')

        dapui.setup {
            layouts = {
                {
                    elements = {
                        { id = "console", size = 0.5 },
                        { id = "scopes",  size = 0.5 },
                    },
                    position = "bottom",
                    size = 10,
                },
            },
            render = {
                indent = 1,
                max_value_lines = 200,
            }
        }

        dap.adapters.codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
                command = '/Users/bmoffett/.local/share/nvim/mason/bin/codelldb',
                args = { '--port', '${port}' },
            }
        }

        dap.configurations.rust = {
            {
                name = "Rust debug",
                type = "codelldb",
                request = "launch",
                showDisassembly = "never",
                stopOnEntry = false,
                program = function()
                    vim.fn.jobstart("cargo build");
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
                end,
                cwd = '${workspaceFolder}',
            },
        }

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("user_defined_lsp", {}),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(args.buf, true)
                end
            end,
        })

        require('lspconfig').gdscript.setup {
            capabilities = capabilities,
            cmd = { "nc", "localhost", "6005" },
        }

        require('lspconfig').rust_analyzer.setup {
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
                    inlay_hints = {
                        closingBraceHints = {
                            enable = true,
                            minLines = 25, -- doesn't seem to work when changed, 25 is the default
                        },
                        typeHints = {
                            enable = true,
                        },
                    },
                }
            }
        }

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

        require('cmp').setup({
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
                -- completion = require('cmp').config.window.bordered(),
                -- documentation = require('cmp').config.window.bordered(),
            },
            sources = require('cmp').config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'nvim_lsp_signature_help' }
            }, {
                { name = 'buffer' },
            })
        })

        -- Set configuration for specific filetype.
        require('cmp').setup.filetype('gitcommit', {
            sources = require('cmp').config.sources({
                { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
                { name = 'buffer' },
            })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        require('cmp').setup.cmdline({ '/', '?' }, {
            mapping = require('cmp').mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        require('cmp').setup.cmdline(':', {
            mapping = require('cmp').mapping.preset.cmdline(),
            sources = require('cmp').config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })
    end
}
