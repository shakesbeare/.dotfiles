return {
	"nvim-lualine/lualine.nvim",
	event = "BufReadPre",
	opts = {
		options = {
			icons_enabled = false,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = { "encoding", "%04B", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	},
	config = function(_, opts)
		local auto_theme = require('lualine.themes.auto')
		auto_theme.normal.b.bg = "None"
		auto_theme.normal.c.bg = "None"

		auto_theme.insert.b.bg = "None"
		auto_theme.insert.c.bg = "None"

		auto_theme.visual.b.bg = "None"
		auto_theme.visual.c.bg = "None"

		auto_theme.command.b.bg = "None"
		auto_theme.command.c.bg = "None"

		opts.options.theme = auto_theme
		require("lualine").setup(opts)
	end,
}
