return {
	"mbbill/undotree",
	config = function() 
		vim.g.undotree_WindowLayout = 4
	end,
	keys = {
		{
			"<leader>u",
			function()
				vim.cmd("UndotreeToggle")
			end,
			silent = true, noremap = true, desc = "Toggle Undo Tree",
		},
	},
}
