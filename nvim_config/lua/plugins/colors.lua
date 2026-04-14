return {
	{
		"shakesbeare/cavernous.nvim",
		lazy = false,
		dir = "~/.dotfiles/nvim_config/lua/plugins/cavernous.nvim",
		name = "cavernous",
		build = function(plug)
			local plug_dir = vim.fn.expand("~") ..
			"/.dotfiles/nvim_config/lua/plugins/cavernous.nvim/"

			local build_script = plug_dir .. "shipwright_build.lua"
			local build = require("shipwright").build
			build(build_script)
		end,
		config = function()
			vim.cmd [[colorscheme cavernous]]
		end
	},
	{
		"rktjmp/lush.nvim",
		cmd = "Lushify",
	},
	{
		"rktjmp/shipwright.nvim",
		lazy = true,
	}
}
