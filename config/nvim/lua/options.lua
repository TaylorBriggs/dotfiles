vim.cmd("filetype plugin on")
vim.cmd("syntax on")
vim.cmd("hi clear SignColumn")

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Backups
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Display
vim.o.background = "dark"
vim.o.colorcolumn = "80"
vim.o.hidden = true
vim.o.autoread = true
vim.o.ruler = true
vim.o.copyindent = true
vim.o.number = true
vim.o.numberwidth = 3
vim.o.showcmd = true
vim.o.showmode = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.termguicolors = true
vim.o.visualbell = true

-- Search
vim.o.hlsearch = true
vim.o.inccommand = "split"
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Whitespace
vim.o.wrap = true
vim.o.linebreak = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.showbreak = "…"
vim.o.smartindent = true

-- Wild menu
vim.o.wildmode = "list:longest,list:full"
vim.o.wildignore = vim.o.wildignore
	.. ",*/.git/*,*/vendor/ruby/**,*/node_modules/**,*/tmp/*,.DS_Store"
vim.o.completeopt = "longest,menuone,menu,preview,noselect"
