function extract_filenames(items)
	local out = {}
	for i, v in ipairs(items) do
		out[i] = v.value
	end
	return out
end

function reduce_path(f, max_length)
	local components = {}
	for component in f:gmatch("([^/\\]+)") do
		table.insert(components, component)
	end

	local current_path = components[#components]
	local path_length = #current_path

	for i = #components - 1, 1, -1 do
		if path_length + 3 + #components[i] > max_length then
			current_path = "..." .. "/" .. current_path
		else
			current_path = components[i] .. "/" .. current_path
			path_length = path_length + #components[i] + 1
		end
	end

	return current_path
end

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<Space>a",
			function()
				require("harpoon"):list():add()
			end,
			noremap = true, silent = true, desc = "Harpoon: add mark",
		},
		{
			"<Space>e",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			noremap = true, silent = true, desc = "Harpoon: view marks",
		},
		{
			"<C-h>",
			function()
				require("harpoon"):list():select(1)
			end,
			noremap = true, silent = true, desc = "Harpoon: nav file 1",
		},
		{
			"<C-t>",
			function()
				require("harpoon"):list():select(2)
			end,
			noremap = true, silent = true, desc = "Harpoon: nav file 2",
		},
		{
			"<C-n>",
			function()
				require("harpoon"):list():select(3)
			end,
			noremap = true, silent = true, desc = "Harpoon: nav file 3",
		},
		{
			"<C-s>",
			function()
				require("harpoon"):list():select(4)
			end,
			noremap = true, silent = true, desc = "Harpoon: nav file 4",
		},
	},
	config = function()
		local harpoon = require('harpoon')
		harpoon:setup()

		if not vim.g.tabline_tree_offset then
			vim.g.tabline_tree_offset = 0
		end

		function tabline()
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
			local max_length = (vim.api.nvim_win_get_width(0) - (5 * 4)) / 4

			for i, f in ipairs(marked_files) do
				if i > 4 then
					break
				end

				local display_path = reduce_path(f, max_length)

				local entry = {}
				if f == current_file then
					table.insert(entry, " %#TablineActive#")
				else
					table.insert(entry, " %#TablineInactive#")
				end

				table.insert(entry, 
					string.format("%d %s %%#TablineInactive#%s", i, display_path, vim.g.tabline_separator))

				s = s .. table.concat(entry)
			end
			s = s .. "%#TablineEnd#"

			return s
		end
		vim.go.tabline = '%!v:lua.tabline()'
	end
}
