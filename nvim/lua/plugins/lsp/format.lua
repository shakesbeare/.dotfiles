return {
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
}
