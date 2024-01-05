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
    return blend(hex, bg or '#000000', amount)
end

--- End

-- *******************************************
-- Customize highlight groups
local do_colors = function()
    -- NvimTreeNormal twice so that it doesn't flash on startup
    local highlight_parens_cmd = string.format("highlight MatchParen guifg=NONE guibg=%s", darken("#FFFFFF", 0.5))
    vim.cmd [[
        colorscheme rose-pine

        highlight @lsp.typemod.variable.mutable.rust gui=underline
        highlight @lsp.typemod.selfKeyword.mutable.rust gui=underline
        highlight DiagnosticUnderlineError gui=undercurl
        highlight DiagnosticUnderlineWarn gui=undercurl
        highlight DiagnosticUnderlineInfo gui=undercurl
        highlight DiagnosticUnderlineHint gui=undercurl
        highlight link @lsp.typemod.comment.documentation.rust @parameter
    ]]
    vim.cmd(highlight_parens_cmd)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- *******************************************

return {
    {
        'rose-pine/neovim',
        config = function(_, _)
            local p = require('rose-pine.palette')
            require("rose-pine").setup {
                disable_italics = true,
                disable_float_background = false,
                disable_background = true,

                highlight_groups = {
                    -- Error and warning backgrounds
                    DiagnosticVirtualTextError = { bg = darken(p.love, 0.1), fg = p.love },
                    DiagnosticVirtualTextWarn = { bg = darken(p.gold, 0.1), fg = p.gold },
                    DiagnosticVirtualTextInfo = { bg = darken(p.foam, 0.1), fg = p.foam },
                    DiagnosticVirtualTextHint = { bg = darken(p.iris, 0.1), fg = p.iris },
                }
            }
            do_colors()
        end
    },
}
