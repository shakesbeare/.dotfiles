return {
    'Vigemus/iron.nvim',
    cmd = 'IronRepl',
    config = function()
        require('iron.core').setup({
            config = {
                -- Whether a repl should be discarded or not
                scratch_repl = true,
                -- Your repl definitions come here
                repl_definition = {
                    sh = {
                        -- Can be a table or a function that
                        -- returns a table (see below)
                        command = { "zsh" }
                    }
                },
                -- How the repl window will be displayed
                -- See below for more information
                repl_open_cmd = require('iron.view').bottom(40),
            },
            keymaps = {
                visual_send = '<C-n>',
                send_line = '<C-n>',
            },
            highlight = {
                italic = true
            },
            ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
        })
    end
}
