local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- unbind annoying stuff
vim.keymap.set("n", "Q", "<nop>", { noremap = true })

-- makes v-block mode a bit better
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, desc = "Allow <C-c> to act as <Esc> in visual mode" })

-- move selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selection down" })

-- Improved yank/delete/paste controls
vim.keymap.set("x", "<leader>p", '"_dP', { noremap = true, desc = "Paste over selection without ruining register" })
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>d", '"_d', { noremap = true, desc = "Delete without ruining register" })
vim.keymap.set("v", "<leader>d", '"_d', { noremap = true, desc = "Delete without ruining register" })

-- Become a master of the universe
vim.keymap.set("n", "<C-p>", function()
	-- pcall to catch KeyboardInterrupt error
	pcall(function()
		local command = vim.fn.input("$❯ ")
		command = command:gsub(".", function(c)
			return "\\" .. c
		end)
		local full_command = ":15split +term\\ " .. command
		vim.cmd(full_command)
		-- go to the end of the output
		local cmd = vim.api.nvim_replace_termcodes("G", true, true, true)
		vim.api.nvim_feedkeys(cmd, "n", true)
	end)
end, { silent = true, noremap = true, desc = "Open split with terminal" })

<<<<<<< Updated upstream
vim.keymap.set("n", "<A-t>", function()
	vim.cmd(":15split +term")
	local cmd = vim.api.nvim_replace_termcodes("i", true, true, true)
	vim.api.nvim_feedkeys(cmd, "n", true)
end, { noremap = true, silent = true, desc = "EZ execute term command" })
=======
-- vim.keymap.set("n", "<M-t>", function()
-- 	vim.cmd(":15split +term")
-- 	local cmd = vim.api.nvim_replace_termcodes("i", true, true, true)
-- 	vim.api.nvim_feedkeys(cmd, "n", true)
-- end, { noremap = true, silent = true, "EZ execute term command" })
>>>>>>> Stashed changes

-- Easier CONSTANT_CASE
vim.keymap.set("i", "<C-u>", function()
	local cmd = vim.api.nvim_replace_termcodes("<C-c>mabviw~`aa", true, true, true)
	vim.api.nvim_feedkeys(cmd, "n", true)
	vim.cmd([[delmarks a]])
end, { noremap = true, silent = true, desc = "Easier CONSTANT_CASE" })

-- Exit terminal mode with <Esc> or <C-[>
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- **********************************************************************
-- LSP Controls
vim.keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end, { noremap = true, silent = true, desc = "Goto definition" })
vim.keymap.set("n", "gi", function()
	vim.lsp.buf.implementation()
end, { noremap = true, silent = true, desc = "Open implementation list" })
vim.keymap.set("n", "<leader>vd", function()
	vim.diagnostic.open_float()
end, { noremap = true, silent = true, desc = "Expand diagnostics on current line" })
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end, { noremap = true, silent = true, desc = "Show hover help" })
vim.keymap.set("n", "<leader>qf", function()
	require("conform").format({ lsp_fallback = "always" })
end, { noremap = true, silent = true, desc = "Format the current buffer" })

vim.keymap.set("n", "<leader>ca", function()
	pcall(function()
		vim.lsp.buf.code_action()
	end)
end, { noremap = true, silent = true, desc = "Show code actions" })
vim.keymap.set("v", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { noremap = true, silent = true, desc = "Show code actions" })
--vim.keymap.set('n', '<leader>ca', function() require('actions-preview').code_actions() end,
--{ noremap = true, silent = true })
vim.keymap.set("n", "<leader>r", function()
	vim.lsp.buf.rename()
end, { noremap = true, silent = true, desc = "Rename symbol" })
vim.keymap.set("i", "<C-k>", function()
	vim.lsp.buf.signature_help()
end, { silent = true })

-- **********************************************************************
--
-- **********************************************************************

-- accept copilot suggestion, if available
-- otherwise, expand luasnip snippet, if available
-- otherwise, expand cmp suggestion, if available
-- otherwise, insert tab/space
vim.keymap.set("i", "<Tab>", function()
	if require("luasnip").expand_or_jumpable() then
		require("luasnip").expand_or_jump()
	elseif has_words_before() then
		require("cmp").confirm({ select = true })
	else
		if vim.o.expandtab then
			vim.api.nvim_feedkeys(string.rep(" ", vim.o.tabstop), "i", true)
		else
			local key = vim.api.nvim_replace_termcodes("<C-v>009", true, false, true)
			vim.api.nvim_feedkeys(key, "i", true)
		end
	end
end, { noremap = true, silent = true, desc = "Expand snippet OR expand cmp OR insert tab/space" })
