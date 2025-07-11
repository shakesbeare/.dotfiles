return {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<leader>t",
			function()
				require("trouble").toggle("diagnostics")
			end,
			noremap = true, silent = true, desc = "LSP: Workspace Diagnostics",
		},
		{
			"<leader>lr",
			function()
				require("trouble").toggle("lsp_references")
			end,
			noremap = true, silent = true, desc = "LSP: References",
		},
		{
			"<leader>ld",
			function()
				require("trouble").toggle("lsp_definitions")
			end,
			noremap = true, silent = true, desc = "LSP: Definitions",
		},
	},
	opts = {
		height = 15,
	},
}
