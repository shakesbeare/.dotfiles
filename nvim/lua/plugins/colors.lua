--- From tokyonight --  Author: Folke -- Thanks Folke!
local function hexToRgb(c)
	c = string.lower(c)
	return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

local function blend(foreground, background, alpha)
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg = hexToRgb(background)
	local fg = hexToRgb(foreground)

	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

local function darken(hex, amount, bg)
	return blend(hex, bg or "#000000", amount)
end

--- End

-- *******************************************
-- Customize highlight groups
local do_colors = function()
	-- NvimTreeNormal twice so that it doesn't flash on startup
	vim.cmd([[
        colorscheme rose-pine
    ]])
	-- vscode
	-- local diag_error = "#F44747"
	-- local diag_warn = "#D7BA7D"
	-- local diag_info = "#18A2FE"
	-- local diag_hint = "#C694E3"

	-- rose-pine
	local p = require('rose-pine.palette')
	local diag_error = p.love
	local diag_warn = p.gold
	local diag_info = p.foam
	local diag_hint = p.iris

	vim.api.nvim_set_hl(0, "@lsp.typemod.variable.mutable.rust", { underline = true })
	vim.api.nvim_set_hl(0, "@lsp.typemod.selfKeyword.mutable.rust", { underline = true })

	vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true })

	vim.api.nvim_set_hl(0, "@lsp.typemod.comment.documentation.rust", { link = "@parameter" })

	vim.api.nvim_set_hl(0, "MatchParen", { bg = darken("#FFFFFF", 0.4) })
	vim.api.nvim_set_hl(0, "Normal", { bg = "none", ctermbg = "none"})
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none", ctermbg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "TelescopeBackground", { bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "none", ctermbg = "none" })
	vim.api.nvim_set_hl(0, "TreesitterContext", { bg = darken("#FFFFFF", 0.1) })
	vim.api.nvim_set_hl(0, "Comment", { fg = darken("#FFFFFF", 0.65) })
	vim.api.nvim_set_hl(0, "@comment", { fg = darken("#FFFFFF", 0.65) })

	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError",{ bg = darken(diag_error, 0.1), fg = diag_error})
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",{ bg = darken(diag_warn, 0.1), fg = diag_warn })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",{ bg = darken(diag_info, 0.1), fg = diag_info })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",{ bg = darken(diag_hint, 0.1), fg = diag_hint })

	vim.api.nvim_set_hl(0, "DiagnosticError",{ bg = darken(diag_error, 0.1), fg = diag_error})
	vim.api.nvim_set_hl(0, "DiagnosticWarn",{ bg = darken(diag_warn, 0.1), fg = diag_warn })
	vim.api.nvim_set_hl(0, "DiagnosticInfo",{ bg = darken(diag_info, 0.1), fg = diag_info })
	vim.api.nvim_set_hl(0, "DiagnosticHint",{ bg = darken(diag_hint, 0.1), fg = diag_hint })

	-- term colors
	vim.g.terminal_color_0 = '#0C0C0C'
	vim.g.terminal_color_1 = '#C50F1F'
	vim.g.terminal_color_2 = '#13A10E'
	vim.g.terminal_color_3 = '#C19C00'
	vim.g.terminal_color_4 = '#0037DA'
	vim.g.terminal_color_5 = '#881798'
	vim.g.terminal_color_6 = '#3A96DD'
	vim.g.terminal_color_7 = '#CCCCCC'
	-- bright colors
	vim.g.terminal_color_8 = '#767676'
	vim.g.terminal_color_9 = '#E74856'
	vim.g.terminal_color_10 = '#16C60C'
	vim.g.terminal_color_11 = '#F9F1A5'
	vim.g.terminal_color_12 = '#3B78FF'
	vim.g.terminal_color_13 = '#B4009E'
	vim.g.terminal_color_14 = '#61D6D6'
	vim.g.terminal_color_15 = '#F2F2F2'
end

return {
	{
		"Mofiqul/vscode.nvim",
		name = "vscode",
		lazy = true,
		config = function(_, _)
			require("vscode").setup({
				italic_comments = false,
				transparent = true,
				group_overrides = {
				}
			})
			do_colors()
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		-- lazy = true,
		config = function(_, _)
			require("rose-pine").setup({
				disable_italics = true,
				disable_float_background = true,
				disable_background = true,
			})
			do_colors()
		end,
	},
}

