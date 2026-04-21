---@diagnostic disable:undefined-global:vim
---@diagnostic disable:unused-function
---@diagnostic disable:unused-local

local function extract_filenames(items)
	local out = {}
	for i, v in ipairs(items) do
		out[i] = v.value
	end
	return out
end

local function reduce_path(f, max_length, replace)
	---@diagnostic disable-next-line
	local replace = replace or ".../"
	local components = {}
	for component in f:gmatch("([^/\\]+)") do
		table.insert(components, component)
	end

	local current_path = components[#components]
	local path_length = #current_path

	for i = #components - 1, 1, -1 do
		if path_length + 5 + #components[i] > max_length then
			current_path = replace .. current_path
		else
			current_path = components[i] .. "/" .. current_path
			path_length = path_length + #components[i] + 1
		end
	end

	return current_path
end

local function harpoon_marks()
	local harpoon = require('harpoon')
	local s = ""
	local fill_amount = vim.g.tabline_tree_offset

	if vim.g.tabline_separator then
		fill_amount = fill_amount - 1
		if fill_amount < 0 then
			fill_amount = 0
		end
	end

	for i = 0, fill_amount do
		s = s .. " "
	end

	if vim.g.tabline_separator then
		s = s .. vim.g.tabline_separator
	end
	local marked_files = extract_filenames(harpoon:list().items)
	local cwd = vim.fn.getcwd()
	local current_file = vim.api.nvim_buf_get_name(0):gsub("^" .. cwd .. "/", "")
	local max_length = vim.api.nvim_win_get_width(0) / 2 / 4

	for i, f in ipairs(marked_files) do
		if i > 4 then
			break
		end

		local display_path = reduce_path(f, max_length, "")

		local entry = {}
		if f == current_file then
			table.insert(entry, " %#TablineActive#")
		else
			table.insert(entry, " %#TablineInactive#")
		end
		table.insert(entry,
			string.format("%d: %s %%#TablineInactive#%s", i, display_path, vim.g.tabline_separator))

		s = s .. table.concat(entry)
	end
	s = s .. "%#TablineEnd#"

	return s
end

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
			lualine_c = { "filetype" },
			lualine_x = { {
				"filename",
				path = 0, -- only display filename without parent dirs
				symbols = {
					modified = "[?]",
					readonly = "[readonly]",
					unnamed = "[#]",
				}
			}, harpoon_marks },
			lualine_y = {},
			lualine_z = {},
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
