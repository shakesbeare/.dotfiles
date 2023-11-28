return {
    'echasnovski/mini.surround',
    event = 'BufRead',
    opts = {},
    config = function(_, opts)
        vim.keymap.set('n', 's', '<nop>');
        require('mini.surround').setup(opts)
    end
}
