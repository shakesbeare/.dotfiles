return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
	cmd = "Telescope",
	keys = {
		{
			"<leader>pf",
			"<cmd>Telescope find_files<CR>",
			desc = "Telescope: All Files",
			silent = true, noremap = true,
		},
		{
			"<leader>f",
			"<cmd>Telescope git_files<CR>",
			desc = "Telescope: Git Files",
			silent = true, noremap = true,
		},
		{
			"<leader>sf",
			"<cmd>Telescope live_grep<CR>",
			desc = "Telescope: Live Grep",
			silent = true, noremap = true,
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
