local M = {}
local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

M.nmap = bind('n', {noremap = false})
M.exprnmap = bind('n', {noremap = false, expr = true})
M.exprimap = bind('i', {noremap = false, expr = true})
M.exprsmap = bind('s', {noremap = false, expr = true})
M.nnoremap = bind('n')
M.vnoremap = bind('v')
M.xnoremap = bind('x')
M.inoremap = bind('i')

return M
