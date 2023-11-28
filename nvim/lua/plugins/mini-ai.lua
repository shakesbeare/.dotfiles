return {
    'echasnovski/mini.ai',
    event = 'BufRead',
    config = function(_, _)
        local gen_spec = require('mini.ai').gen_spec
        require('mini.ai').setup {
            custom_textobjects = {
                F = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
            },
            n_lines = 100,
        }
    end
}
