set encoding=utf-8
set fileencoding=utf-8
set nocompatible
filetype off

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install Vim-Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vimplug_exists=expand('~/.local/share/nvim/site/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif

  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall!
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! LC_Install(info)
  if a:info.status == 'installed' || a:info.force
    !/bin/bash install.sh
    !npm install -g javascript-typescript-langserver
  endif
endfunction

call plug#begin(expand('~/.local/share/nvim/plugged'))

" Utilities
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': function('LC_Install'),
  \ }
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'rizzatti/dash.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'editorconfig/editorconfig-vim'
Plug 'yggdroot/indentLine'

" Color schemes
Plug 'dracula/vim', { 'as': 'dracula' }

" tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" Language support
Plug 'sheerun/vim-polyglot'
Plug 'jparise/vim-graphql'
Plug 'tpope/vim-markdown'
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'

" Frameworks
Plug 'tpope/vim-rails'

call plug#end()

filetype plugin indent on

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

nnoremap <Leader>h :nohl<CR>

if (executable('ag'))
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
endif

nnoremap <Leader>t :Files<CR>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

augroup NERDTree
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd VimEnter * if (&filetype !=# 'gitcommit' && &filetype !=# 'gitrebase') | NERDTree | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTree.isTabTree()) | q | endif
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
  \ }

autocmd FileType html,css,javascript.jsx EmmetInstall

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:polyglot_disabled = ['markdown'] " Use tpope/vim-markdown instead
let g:markdown_fenced_languages = ['javascript', 'json', 'sql', 'elixir',
\ 'ruby', 'bash=sh']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" python3 installed via asdf
let g:python3_host_prog = expand($ASDF_DIR . "/shims/python")
let g:deoplete#enable_at_startup = 1

" Map `<tab>` to Deoplete
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space()
  \ ? "\<TAB>"
  \ : deoplete#mappings#manual_complete()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : ''

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neosnippet
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LanguageClient
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:LanguageClient_serverCommands = {
  \ 'javascript.jsx': ['npx', 'javascript-typescript-stdio'],
  \ 'javascript': ['npx', 'javascript-typescript-stdio'],
  \ 'typescript': ['npx', 'javascript-typescript-stdio']
  \ }

function! LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  endif
endfunction

autocmd FileType * call LC_maps()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_error = '✖︎'
let g:ale_sign_warning = '⚠'
let g:ale_linters = {
  \ 'erb': [''],
  \ 'graphql': ['gqlint']
  \ }
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'javascript': ['eslint'],
  \ 'javascript.jsx': ['eslint'],
  \ 'typescript': ['tslint'],
  \ 'typescript.tsx': ['tslint'],
  \ 'json': ['prettier'],
  \ 'ruby': ['rubocop']
  \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Closetag
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:closetag_filenames = '*.html,*.jsx,*.js'
let g:closetag_xhtml_filenames = '*.jsx,*.js'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gutentags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gutentags_exclude_filetypes = ['gitcommit', 'gitrebase']
au FileType gitcommit,gitrebase let g:gutentags_enabled=0
