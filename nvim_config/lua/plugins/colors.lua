return {
	{
		"shakesbeare/cavernous.nvim",
		name = "cavernous",
		config = function()
			vim.cmd[[colorscheme cavernous]]
			vim.api.nvim_set_hl(0, "TablineActive", { fg = "#e7ef8f", bold = true })
			vim.api.nvim_set_hl(0, "TablineInactive", { })
			vim.api.nvim_set_hl(0, "TablineEnd", { })
		end
	}
}
