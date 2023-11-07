
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
    vim.cmd[[
        colorscheme tokyonight

        highlight @lsp.typemod.variable.mutable.rust gui=underline
        highlight @lsp.typemod.selfKeyword.mutable.rust gui=underline
        highlight DiagnosticUnderlineError gui=undercurl
        highlight DiagnosticUnderlineWarn gui=undercurl
        highlight DiagnosticUnderlineInfo gui=undercurl
        highlight DiagnosticUnderlineHint gui=undercurl
        highlight link @lsp.typemod.comment.documentation.rust @parameter

        highlight NvimTreeNormal guibg=NONE ctermbg=NONE
    ]]
end

-- *******************************************

return {
    {
        'rose-pine/neovim',
        lazy = true,
        config = function(_, opts)
            local p = require('rose-pine.palette')
            require("rose-pine").setup {
                disable_italics = true,
                disable_float_background = false,

                highlight_groups = {
                    -- Error and warning backgrounds
                    DiagnosticVirtualTextError = { bg = darken(p.love, 0.1), fg = p.love },
                    DiagnosticVirtualTextWarn = { bg = darken(p.gold, 0.1), fg = p.gold },
                    DiagnosticVirtualTextInfo = { bg = darken(p.foam, 0.1), fg = p.foam },
                    DiagnosticVirtualTextHint = { bg = darken(p.iris, 0.1), fg = p.iris },
                }
            }
        end
    },
    {
        'ellisonleao/gruvbox.nvim',
        lazy = true,
        config = function(_, opts)
            require("gruvbox").setup({
                underline = true,
                italic = false,
                contrast = "hard",
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
            })
        end,
    },
    {
        'folke/tokyonight.nvim',
        config = function(_, opts)
            require("tokyonight").setup({
                style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                light_style = "day", -- The theme is used when the background is set to light
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false, bg = 000000 },
                    keywords = { italic = false },
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "light", -- style for floating windows
                },
            })
            do_colors()
        end
    },
    {
        'Mofiqul/vscode.nvim',
        lazy = true,
        config = function(_, _)
            local c = require('vscode.colors').get_colors()
            require('vscode').setup({
                group_overrides = {
                    -- Error and warning backgrounds
                    DiagnosticVirtualTextError = { bg = darken(c.vscRed, 0.1), fg = c.vscRed},
                    DiagnosticVirtualTextWarn = { bg = darken(c.vscYellowOrange, 0.1), fg = c.vscYellowOrange },
                    DiagnosticVirtualTextInfo = { bg = darken(c.vscPink, 0.1), fg = c.vscPink },
                    DiagnosticVirtualTextHint = { bg = darken(c.vscLightBlue, 0.1), fg = c.vscLightBlue },
                }
            })
        end,
    }
}

