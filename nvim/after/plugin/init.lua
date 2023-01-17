-- plugins which require no setup go here
-- or general setup which should take place
-- after plugins are loaded
require('nvim-autopairs').setup {}

vim.g.vimtex_view_method = 'skim'
vim.g.vimtex__compiler_method = 'latexmk'
vim.g.tex_flavor = 'latex'
vim.g.tex_conceal = "sabgm"

vim.cmd([[
    autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
]])

