---@diagnostic disable:undefined-global:vim
---@diagnostic disable:unused-function

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VimEnter",
	config = function()
		local harpoon = require('harpoon')
		harpoon:setup()

		if not vim.g.tabline_tree_offset then
			vim.g.tabline_tree_offset = 0
		end
	end
}
