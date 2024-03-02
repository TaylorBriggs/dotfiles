return {
  'rmagatti/auto-session',
  config = function ()
    require('auto-session').setup({
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      session_lens = {
        buftypes_to_ignore = { 'gitcommit', 'gitrebase' },
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
    })

    vim.keymap.set('n', '<leader>ls', require('auto-session.session-lens').search_session, { noremap = true })
    vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
  end
}
