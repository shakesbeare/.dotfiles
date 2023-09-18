return {
    'nvim-treesitter/nvim-treesitter',
    event = "BufRead",
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-context' },
        { 'nvim-treesitter/playground' }
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup {
            ignore_install = { "phpdoc" },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" }
            },
            indent = {
                enable = true,
            },
            playground = {
                enable = true
            },
            rainbow = {
                enable = true,
            },
            autotag = {
                enable = true,
                filetypes = {
                    'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx',
                    'jsx', 'rescript',
                    'xml',
                    'php',
                    'markdown',
                    'astro', 'glimmer', 'handlebars', 'hbs',
                    'rust'
                },
            }
        }

        require('treesitter-context').setup {
            enable = true,
            max_lines = 0,
            trim_scope = 'outer',
            min_window_height = 0,
            patterns = {
                default = {
                    'class',
                    'function',
                    'method',
                    'while',
                    'for',
                    'if',
                    'switch',
                    'case'
                },
                rust = {
                    'impl_item',
                    'struct',
                    'enum',
                },
                scala = {
                    'object_definition',
                },
                vhdl = {
                    'process_statement',
                    'architecture_body',
                    'entity_declaration',
                },
                markdown = {
                    'section',
                },
                elixir = {
                    'anonymous_function',
                    'arguments',
                    'block',
                    'do_block',
                    'list',
                    'map',
                    'tuple',
                    'quoted_content',
                },
                json = {
                    'pair',
                },
                yaml = {
                    'block_mapping_pair',
                },
            },
            exact_patterns = {
                -- Example for a specific filetype with Lua patterns
                -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
                -- exactly match "impl_item" only)
                -- rust = true,
            },
            zindex = 20,
            mode = 'cursor',
            separator = nil
        }

        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        parser_config.supercollider = {
            install_info = {
                url = "https://github.com/madskjeldegaard/tree-sitter-supercollider",
                files = { "src/parser.c" },
                maintainer = "@madskjeldegaard"
            },
            filetype = "supercollider",
        }
    end
}
