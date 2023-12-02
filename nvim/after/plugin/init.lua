-- plugins which require no setup go here
-- or general setup which should take place
-- after plugins are loaded

local get_buf_as_str = function(bufnr)
    local text = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    return table.concat(text, "\n")
end

local uses_tabs = function(bufnr)
	local text = get_buf_as_str(bufnr)
	local spaces_substring = string.rep(' ', vim.o.tabstop)
	local _, t_count = string.gsub(text, "\t", "")
	local _, s_count = string.gsub(text, spaces_substring, "")

	if t_count > s_count then
		return true
	else
		return false
	end
end

-- set expandtab based on whether the file uses tabs or not
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("user_defined", {}),
	callback = function(ev)
		if uses_tabs(ev.buf) then
			vim.o.expandtab = false
		else
			vim.o.expandtab = true
		end
	end,
})

vim.api.nvim_create_autocmd("Filetype", {
	group = vim.api.nvim_create_augroup("gdcomment", {}),
	pattern = "gdscript",
	callback = function(ev)
		vim.api.nvim_buf_set_option(ev.buf, "commentstring", "# %s")
	end
})
