return {
	{
		"mfussenegger/nvim-dap",
		keys = {},
		config = function()
			local dap = require("dap")

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "/Users/bmoffett/.local/share/nvim/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					name = "Rust debug",
					type = "codelldb",
					request = "launch",
					showDisassembly = "never",
					stopOnEntry = false,
					program = function()
						vim.fn.jobstart("cargo build")
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
			}
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		cmd = "Mason",
		dependencies = "williamboman/mason.nvim",
		opts = {},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Begin debugging",
				{ silent = true, noremap = true },
			},
			{
				"<F1>",
				function()
					require("dap").step_over()
				end,
				desc = "Debugging: step over",
				{ silent = true, noremap = true },
			},
			{
				"<F2>",
				function()
					require("dap").step_into()
				end,
				desc = "Debugging: step into",
				{ silent = true, noremap = true },
			},
			{
				"<F3>",
				function()
					require("dap").step_out()
				end,
				desc = "Debugging: step out",
				{ silent = true, noremap = true },
			},
			{
				"<leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debugging: Toggle breakpoint",
				{ silent = true, noremap = true },
			},
			{
				"<leader>wf",
				function()
					local element = vim.fn.input("Element name: ")
					require("dapui").float_element(element, { enter = true, position = "center" })
				end,
				desc = "Debugging: Float UI element in dap_ui",
				{ silent = true, noremap = true },
			},
		},
		opts = {
			layouts = {
				{
					elements = {
						{ id = "console", size = 0.5 },
						{ id = "scopes", size = 0.5 },
					},
					position = "bottom",
					size = 10,
				},
			},
			render = {
				indent = 1,
				max_value_lines = 200,
			},
		},
		config = function(_, opts)
			require("dapui").setup(opts)

			local dap = require("dap")
			local dapui = require("dapui")

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
