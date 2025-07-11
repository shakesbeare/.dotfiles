return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					{ "saadparwaiz1/cmp_luasnip" },
					{ "rafamadriz/friendly-snippets" },
				},
				config = function(_, _)
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		config = function(_, _)
			require("cmp").setup({
				mapping = require("cmp").mapping.preset.insert({
					["<C-n>"] = require("cmp").mapping.select_next_item(),
					["<C-p>"] = require("cmp").mapping.select_prev_item(),
					["<C-y>"] = require("cmp").mapping.confirm(),
				}),
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					-- completion = require('cmp').config.window.bordered(),
					-- documentation = require('cmp').config.window.bordered(),
				},
				sources = require("cmp").config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "nvim_lsp_signature_help" },
				}, {
					{ name = "buffer" },
				}),
			})

			-- Set configuration for specific filetype.
			require("cmp").setup.filetype("gitcommit", {
				sources = require("cmp").config.sources({
					{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
				}, {
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			require("cmp").setup.cmdline({ "/", "?" }, {
				mapping = require("cmp").mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			require("cmp").setup.cmdline(":", {
				mapping = require("cmp").mapping.preset.cmdline(),
				sources = require("cmp").config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
