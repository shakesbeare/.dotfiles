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
			"<C-h>",
			function()
				require("harpoon.ui").nav_file(1)
			end,
			{ noremap = true, silent = true },
		},
		{
			"<C-t>",
			function()
				require("harpoon.ui").nav_file(2)
			end,
			{ noremap = true, silent = true },
		},
		{
			"<C-n>",
			function()
				require("harpoon.ui").nav_file(3)
			end,
			{ noremap = true, silent = true },
		},
		{
			"<C-s>",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			{ noremap = true, silent = true },
		},
	},
	opts = {},
}
