return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'leoluz/nvim-dap-go',
    'rcarriga/nvim-dap-ui',
  },
  config = function()
    require('dapui').setup()
    require('dap-go').setup()

    local dap, dapui = require('dap'), require('dapui')

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

    vim.keymap.set('n', '<leader>dt', ':DapToggleBreakpoint<CR>')
    vim.keymap.set('n', '<leader>dc', ':DapContinue<CR>')
    vim.keymap.set('n', '<leader>dx', ':DapTerminate<CR>')
    vim.keymap.set('n', '<leader>do', ':DapStepOver<CR>')
  end
}
