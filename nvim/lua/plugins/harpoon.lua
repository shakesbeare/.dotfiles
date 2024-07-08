return {
	"ThePrimeagen/harpoon",
	keys = {
		{
			"<Space>a",
			function()
				require("harpoon.mark").add_file()
			end,
			{ noremap = true, silent = true },
		},
		{
			"<Space>e",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			{ noremap = true, silent = true },
		},
		{
			"<C-j>",
			function()
				require("harpoon.ui").nav_file(1)
			end,
			{ noremap = true, silent = true },
		},
		{
			"<C-k>",
			function()
				require("harpoon.ui").nav_file(2)
			end,
			{ noremap = true, silent = true },
		},
		{
			"<C-l>",
			function()
				require("harpoon.ui").nav_file(3)
			end,
			{ noremap = true, silent = true },
		},
		{
			"<C-;>",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			{ noremap = true, silent = true },
		},
	},
	opts = {},
}
