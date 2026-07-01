return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = "false",
		branch = "main",
		build = ":TSUpdate",
		dependencies = {
		},
		config = function(_, _)
			-- features desired:
			--     highlight ✓
			--     indent ✓
			--     rainbow
			--     autotag

			-- configure nvim-treesitter
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter.setup", {}),
				callback = function(args)
					local buf = args.buf
					local filetype = args.match

					-- Prevent treesitter from trying to enable on things like oil.nvim buffers
					local language = vim.treesitter.language.get_lang(filetype) or filetype
					if not vim.treesitter.language.add(language) then 
						return
					end
					-- enable highlights
					vim.treesitter.start() 
					-- enable folding
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"
					-- enable indent
					vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
				end,
			})
		end,
	},
	-- { 
	-- 	"nvim-treesitter/nvim-treesitter-context", 
	-- 	branch = "master", 
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- 	config = function() 
	-- 		-- enable context
	-- 		require("treesitter-context").setup({
	-- 			enable = true,
	-- 			max_lines = 0,
	-- 			trim_scope = "outer",
	-- 			min_window_height = 0,
	-- 			multiline_threshold = 20,
	-- 			zindex = 20,
	-- 			mode = "cursor",
	-- 			separator = nil,
	-- 		})
	-- 	end
	-- },
	{ 
		"nvim-treesitter/nvim-treesitter-textobjects", 
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function() 
			require("nvim-treesitter-textobjects").setup({
				
			})
			-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/main/BUILTIN_TEXTOBJECTS.md
			local to_select = require("nvim-treesitter-textobjects.select")
			local to_move = require("nvim-treesitter-textobjects.move")
			local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

			-- selection texto_selectbjects
			vim.keymap.set({ "x", "o" }, "af", function() 
				to_select.select_textobject("@function.outer", "textobjects")
			end)

			vim.keymap.set({ "x", "o" }, "if", function() 
				to_select.select_textobject("@function.inner", "textobjects")
			end)

			-- movements
			vim.keymap.set({ "n", "x", "o" }, "]f", function()
				to_move.goto_next_start("@function.outer", "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "[f", function()
				to_move.goto_previous_start("@function.outer", "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "]c", function()
				to_move.goto_next_start("@class.outer", "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "[c", function()
				to_move.goto_previous_start("@class.outer", "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "]n", function() 
				to_move.goto_next_start({"@class.outer", "@function.outer"}, "textobjects")
			end)

			vim.keymap.set({ "n", "x", "o" }, "[n", function() 
				to_move.goto_next_start({"@class.outer", "@function.outer"}, "textobjects")
			end)

			-- enable ;/,
			-- ; always goes in the same direction while , always moves opposite
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

			-- make f/F and t/T repeatable
			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

		end
	},
}
