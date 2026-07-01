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
vim.keymap.set("x", "<leader>p", '"_dP', { noremap = true, desc = "Paste over selection lossy" })
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>d", '"_d', { noremap = true, desc = "Delete lossy" })
vim.keymap.set("v", "<leader>d", '"_d', { noremap = true, desc = "Delete lossy" })

-- Harpoon controls
vim.keymap.set("n", "<Space>a", function() require("harpoon"):list():add() end,
	{ noremap = true, silent = true, desc = "Harpoon: add mark", })
vim.keymap.set("n", "<Space>e", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
	{ noremap = true, silent = true, desc = "Harpoon: view marks", })
vim.keymap.set("n", "<C-h>", function() require("harpoon"):list():select(1) end,
	{ noremap = true, silent = true, desc = "Harpoon: nav file 1", })
vim.keymap.set("n", "<C-t>", function() require("harpoon"):list():select(2) end,
	{ noremap = true, silent = true, desc = "Harpoon: nav file 2", })
vim.keymap.set("n", "<C-n>", function() require("harpoon"):list():select(3) end,
	{ noremap = true, silent = true, desc = "Harpoon: nav file 3", })
vim.keymap.set("n", "<C-s>", function() require("harpoon"):list():select(4) end,
	{ noremap = true, silent = true, desc = "Harpoon: nav file 4", })

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
end, { silent = true, noremap = true, desc = "Execute Terminal Command" })

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
end, { silent = true, noremap = true, desc = "Execute Terminal Command" })

vim.keymap.set("n", "<A-t>", function()
	vim.cmd(":15split +term")
	local cmd = vim.api.nvim_replace_termcodes("i", true, true, true)
	vim.api.nvim_feedkeys(cmd, "n", true)
end, { noremap = true, silent = true, desc = "Open Terminal Split" })

-- Easier CONSTANT_CASE
vim.keymap.set("i", "<C-u>", function()
	local cmd = vim.api.nvim_replace_termcodes("<C-c>mabviw~`aa", true, true, true)
	vim.api.nvim_feedkeys(cmd, "n", true)
	vim.cmd([[delmarks a]])
end, { noremap = true, silent = true, desc = "Toggle case for previous word" })

-- Exit terminal mode with <Esc> or <C-[>
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- **********************************************************************
-- LSP Controls
vim.keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end, { noremap = true, silent = true, desc = "LSP: Goto Definition" })
vim.keymap.set("n", "<leader>li", function()
	vim.lsp.buf.implementation()
end, { noremap = true, silent = true, desc = "LSP: Implementation List" })
vim.keymap.set("n", "<leader>vd", function()
	vim.diagnostic.open_float()
end, { noremap = true, silent = true, desc = "LSP: Expand diagnostics" })
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end, { noremap = true, silent = true, desc = "LSP: Show Hover" })
vim.keymap.set("n", "<leader>qf", function()
	require("conform").format({ lsp_fallback = "always" })
end, { noremap = true, silent = true, desc = "LSP: Format the current buffer" })

vim.keymap.set("n", "<leader>la", function()
	pcall(function()
		vim.lsp.buf.code_action()
	end)
end, { noremap = true, silent = true, desc = "LSP: Show code actions" })
vim.keymap.set("v", "<leader>la", function()
	vim.lsp.buf.code_action()
end, { noremap = true, silent = true, desc = "LSP: Show code actions" })
--vim.keymap.set('n', '<leader>ca', function() require('actions-preview').code_actions() end,
--{ noremap = true, silent = true })
vim.keymap.set("n", "<leader>r", function()
	vim.lsp.buf.rename()
end, { noremap = true, silent = true, desc = "LSP: Rename symbol" })
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
	if require("luasnip").jumpable() then
		require("luasnip").jump()
	else
		if vim.o.expandtab then
			vim.api.nvim_feedkeys(string.rep(" ", vim.o.tabstop), "i", true)
		else
			local key = vim.api.nvim_replace_termcodes("<C-v>009", true, false, true)
			vim.api.nvim_feedkeys(key, "i", true)
		end
	end
end, { noremap = true, silent = true, desc = "Expand snippet OR expand cmp OR insert tab/space" })
