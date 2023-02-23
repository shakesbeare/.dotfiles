local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

-- Language server management
Plug('neovim/nvim-lspconfig')
Plug('jose-elias-alvarez/null-ls.nvim')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('nvim-treesitter/nvim-treesitter-context')
Plug('nvim-treesitter/playground')
Plug('simrat39/rust-tools.nvim')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')

-- -- Editing Ergonomics
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-vsnip')
Plug('hrsh7th/vim-vsnip')
Plug('godlygeek/tabular')
Plug('mbbill/undotree')
Plug('hrsh7th/cmp-nvim-lsp-signature-help')
Plug('windwp/nvim-autopairs')
Plug('abecodes/tabout.nvim')
Plug('terrortylor/nvim-comment')
Plug('kylechui/nvim-surround')

-- Controls and Navigation
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', {tag = '0.1.0'})
Plug('ThePrimeagen/harpoon')

-- Visual
Plug('nvim-lualine/lualine.nvim')
Plug('kyazdani42/nvim-web-devicons')
Plug('xiyaowong/nvim-transparent')
Plug('ellisonleao/gruvbox.nvim')
Plug('folke/tokyonight.nvim', { branch = 'main' })
Plug('rose-pine/neovim')

-- Parsers and stuff
Plug('epwalsh/obsidian.nvim')
Plug('davidgranstrom/scnvim')

vim.call('plug#end')


