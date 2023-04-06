set encoding=utf-8
set fileencoding=utf-8
set nocompatible
filetype off

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Utility function for getting system paths
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! GetSystemPath(command)
  return trim(system(a:command))
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install Vim-Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif

  echo "Installing Vim-Plug..."
  echo ""
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  autocmd VimEnter * PlugInstall! --sync | source ~/.config/nvim/init.vim
end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(stdpath('data') . '/plugged')

let fzf_path = GetSystemPath('brew --prefix fzf')
" Utilities
Plug fzf_path
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'editorconfig/editorconfig-vim'
Plug 'yggdroot/indentLine'

" Color schemes
Plug 'dracula/vim', { 'as': 'dracula' }

" tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" Language support
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
Plug 'dense-analysis/ale'

let g:polyglot_disabled = ['markdown'] " Use tpope/vim-markdown instead
Plug 'sheerun/vim-polyglot'
Plug 'jparise/vim-graphql'
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
Plug 'tpope/vim-rails'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader and mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=" "

nmap <Leader>bd :bufdo bd!<CR>
nmap <Leader>\ :NERDTreeToggle \| :silent NERDTreeMirror<CR>

" Remove trailing whitespace
nmap <Leader>fw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Quick buffer switching
nnoremap <Leader><Leader> <C-^>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
set termguicolors
set background=dark

set noshowmode
let g:lightline = {
 \ 'colorscheme': 'dracula',
 \ }

colorscheme dracula
hi clear SignColumn

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use a more logical Y
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap Y y$

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change cursor shape between modes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backup Preferences
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup
set nowritebackup
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display Preferences
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set colorcolumn=80
set hidden
set autoread
set ruler
set copyindent
set number
set numberwidth=3
set showcmd
set splitright

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Whitespace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nowrap
set linebreak
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set listchars=tab:▸\ ,trail:·,eol:¬
set showbreak=…
set smartindent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Whitespace Highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch
set inccommand=split
set incsearch
set ignorecase
set smartcase

nnoremap <leader>h :nohl<cr>
nnoremap <leader>f :Rg<cr>
nnoremap <leader>t :Files<cr>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --color always --column --line-number --no-heading --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let preview_opts = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  let grep_opts = fzf#vim#with_preview(preview_opts, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, grep_opts, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab completion options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set wildmode=list:longest,list:full
set wildignore+=*/.git/*,*/vendor/ruby/**,*/_build/**,*/deps/**,*/tmp/*,.DS_Store
set complete=.,w,t
set completeopt=longest,menuone,preview

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Less Annoying Bell
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set visualbell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeCaseSensitiveSort = 1
let NERDTreeWinPos = "left"
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['.git$[[dir]]', '.DS_Store']
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1

function! s:CheckToOpenNERDTree() abort
  if (&ft == 'gitcommit' || &ft == 'gitrebase')
    return
  endif

  NERDTree
endfunction

function! s:CheckToCloseNERDTree() abort
  if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTree.isTabTree())
    quit
  endif
endfunction

augroup NERDTree
  autocmd VimEnter * call s:CheckToOpenNERDTree()
  autocmd bufenter * call s:CheckToCloseNERDTree()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype & Syntax Coercion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Force markdown to hard wrap
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile * if expand('%:t') !~ '\.' | setlocal textwidth=80 | endif

" setup js libraries syntax
let g:used_javascript_libs = 'underscore,react'

" emmet
let g:user_emmet_install_global=0
let g:user_emmet_settings = {
  \ 'javascript': { 'extends': 'jsx' },
  \ 'javascript.jsx': { 'extends': 'jsx' },
  \ 'javascriptreact': { 'extends': 'jsx' },
  \ }

autocmd FileType html,css,javascript.jsx,javascriptreact EmmetInstall

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:markdown_fenced_languages = ['javascript', 'json', 'sql', 'elixir',
\ 'ruby', 'bash=sh']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LanguageClient
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:loaded_perl_provider = 0
let g:python3_host_prog = GetSystemPath('which python')
let g:node_host_prog = GetSystemPath('which neovim-node-host')
let g:ruby_host_prog = GetSystemPath('which neovim-ruby-host')

let typescript_language_server = GetSystemPath('which typescript-language-server')
let solargraph = GetSystemPath('which solargraph')
let js_command = [typescript_language_server, '--stdio']
let g:LanguageClient_serverCommands = {
  \ 'javascriptreact': js_command,
  \ 'javascript.jsx': js_command,
  \ 'javascript': js_command,
  \ 'typescript': js_command,
  \ 'ruby': [solargraph, 'stdio'],
  \ }

function! LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nmap <buffer> <silent> K <Plug>(lcn-hover)
    nmap <buffer> <silent> gd <Plug>(lcn-definition)
    nmap <buffer> <silent> <F2> <Plug>(lcn-rename)
  endif
endfunction

autocmd FileType * call LC_maps()

nmap <F5> <Plug>(lcn-menu)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_fix_on_save = 0
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 1000
let g:ale_sign_error = '🚫'
let g:ale_sign_warning = '⚠️ '
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'javascript.jsx': ['eslint'],
  \ 'javascriptreact': ['eslint'],
  \ 'jsx': ['eslint'],
  \ 'ruby': ['rubocop'],
  \ }
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'javascript': ['eslint'],
  \ 'javascript.jsx': ['eslint'],
  \ 'javascriptreact': ['eslint'],
  \ 'jsx': ['eslint'],
  \ 'json': ['prettier'],
  \ 'ruby': ['rubocop'],
  \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Closetag
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:closetag_filenames = '*.html,*.jsx,*.js'
let g:closetag_xhtml_filenames = '*.jsx,*.js'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gutentags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gutentags_ctags_executable = GetSystemPath('which ctags')
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitrebase']
