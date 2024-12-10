local shell_helpers = require("helpers.shell_helpers")

vim.g.node_host_prog =
    shell_helpers.system_stdout({ "mise", "which", "neovim-node-host" })
vim.g.python3_host_prog =
    shell_helpers.system_stdout({ "mise", "which", "python" })
vim.g.ruby_host_prog =
    shell_helpers.system_stdout({ "mise", "which", "neovim-ruby-host" })

-- https://github.com/junegunn/fzf/blob/master/README-VIM.md#installation
vim.opt.rtp:append("/opt/homebrew/opt/fzf")
