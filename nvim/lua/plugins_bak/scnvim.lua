return {
    'davidgranstrom/scnvim',
    ft = "scd, sc",
    config = function(_, _)
        local scnvim = require('scnvim')
        local map = scnvim.map

        scnvim.setup {
            keymaps = {
                ['<C-n>'] = {
                    map('editor.send_block', { 'i', 'n' }),
                    map('editor.send_selection', 'x'),
                },
                ['<leader>.'] = map('sclang.hard_stop', { 'n', 'x' }),
                ['<leader>sta'] = map('sclang.start', { 'n', 'x' }),
                ['<leader>sto'] = map('sclang.stop', { 'n', 'x' })
            },
            postwin = {
                highlight = true,
            }
        }
    end
}
