require("gruvbox").setup({
    underline = true,
    italic = false,
    contrast = "hard",
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
})

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
    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors)
    end,
    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors)

    end,
})

vim.cmd(
    'colorscheme darkplus'
)

