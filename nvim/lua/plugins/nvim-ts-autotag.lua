return {
    "windwp/nvim-ts-autotag",
    config = function(_, opts)
        require('nvim-ts-autotag').setup {
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
    end
}
