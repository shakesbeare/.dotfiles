return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
	keys = {
		{
			"<leader>pf",
			"<cmd>Telescope find_files<CR>",
			desc = "Fuzzy find all files",
			{ silent = true, noremap = true },
		},
		{
			"<C-p>",
			"<cmd>Telescope git_files<CR>",
			desc = "Fuzzy find git files",
			{ silent = true, noremap = true },
		},
		{
			"<leader>sf",
			"<cmd>Telescope live_grep<CR>",
			desc = "Grep for input",
			{ silent = true, noremap = true },
		},
	},
	opts = {
		defaults = {
			mappings = {
				i = {
					["<C-y>"] = "select_default",
					-- ["<CR>"] = actions.select_default,
				},
				n = {
					["<C-y>"] = "select_default",
					-- ["<CR>"] = actions.select_default,
				},
			},
		},
	},
}
