local nmap = function(keys, func)
	vim.keymap.set("n", keys, func)
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("dapui").setup()
			require("dap-go").setup()

			local dap, dapui = require("dap"), require("dapui")

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			nmap("<leader>dt", ":DapToggleBreakpoint<CR>")
			nmap("<leader>dc", ":DapContinue<CR>")
			nmap("<leader>dx", ":DapTerminate<CR>")
			nmap("<leader>do", ":DapStepOver<CR>")
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local trouble = require("trouble")

			nmap("<leader>xx", trouble.toggle)
			nmap("<leader>xw", function()
				trouble.toggle("workspace_diagnostics")
			end)
			nmap("<leader>xd", function()
				trouble.toggle("document_diagnostics")
			end)
			nmap("<leader>xq", function()
				trouble.toggle("quickfix")
			end)
			nmap("<leader>xl", function()
				trouble.toggle("loclist")
			end)
		end,
	},
}
