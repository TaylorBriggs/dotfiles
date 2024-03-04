return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup({
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      default_component_configs = {
        git_status = {
          symbols = {
            conflict = '',
            ignored = '☒',
            modified = '•',
            renamed = '→',
            staged = '✓',
            unstaged = '✗',
            untracked = '*',
          },
        },
      },
      event_handlers = {
        {
          event = 'file_opened',
          handler = function(_)
            require('neo-tree.command').execute({ action = 'close' })
          end
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_pattern = {
            '.git*',
          },
          never_show = {
            '.DS_Store',
            'tags',
          },
        },
      },
    })

    vim.keymap.set('n', '<leader>\\', ':Neotree filesystem toggle left<CR>', {})
    vim.keymap.set('n', '<leader>bf', ':Neotree buffers reveal float<CR>', {})
  end
}
