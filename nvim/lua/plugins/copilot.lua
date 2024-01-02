return {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "BufReadPre",
    opts = {
        panel = {
            enabled = true,
        },
        suggestion = {
            enabled = true,
            keymap = {
                next = "<C-e>"
            }
        }
    }
}
