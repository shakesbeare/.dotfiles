-- plugins which require no setup go here
-- or general setup which should take place
-- after plugins are loaded

vim.cmd([[
    autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
]])

