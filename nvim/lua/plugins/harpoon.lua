return {
	"ThePrimeagen/harpoon",
	keys = {
		{
			"<Space>a",
			function()
				require("harpoon.mark").add_file()
			end,
			{ noremap = true, silent = true, desc = "Harpoon: add mark"},
		},
		{
			"<Space>e",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			{ noremap = true, silent = true, desc = "Harpoon: view marks" },
		},
		{
			"<C-j>",
			function()
				require("harpoon.ui").nav_file(1)
			end,
			{ noremap = true, silent = true, desc = "Harpoon: nav file 1" },
		},
		{
			"<C-k>",
			function()
				require("harpoon.ui").nav_file(2)
			end,
			{ noremap = true, silent = true, desc = "Harpoon: nav file 2" },
		},
		{
			"<C-l>",
			function()
				require("harpoon.ui").nav_file(3)
			end,
			{ noremap = true, silent = true, desc = "Harpoon: nav file 3" },
		},
		{
			"<C-;>",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			{ noremap = true, silent = true, desc = "Harpoon: nav file 4" },
		},
	},
	opts = {},
}
