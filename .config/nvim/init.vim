"#########################
"#            _
"# _ ____   _(_)_ __ ___
"#| '_ \ \ / / | '_ ` _ \
"#| | | \ V /| | | | | | |
"#|_| |_|\_/ |_|_| |_| |_|
"#
"#########################

" #### PLUGINS ####
"" Plugs - :source % ; :PlugInstal ; remover: :PlugClean
call plug#begin()

" For Commenting gcc & gc
Plug 'https://github.com/tpope/vim-commentary'
" Tagbar for code navigation
Plug 'https://github.com/preservim/tagbar'

" NerdTree
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Syntax
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'

" Auto Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

" Formater
Plug 'Chiel92/vim-autoformat'

" Themes
Plug 'rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'rafamadriz/themes.nvim'

call plug#end()


" ## BASIC ##
set title
set mouse=a
syntax on
set scrolloff=8
set number
set relativenumber
set linebreak
set showmatch
set list lcs=trail:·

" ## search ##
set hlsearch
set smartcase
set ignorecase
set incsearch

" ## editor behavior ##
set undolevels=1000
set backspace=indent,eol,start
set noswapfile
set nobackup
set nowritebackup
set clipboard=unnamedplus
set encoding=utf-8
set autoread
filetype on
filetype plugin on
filetype indent on
" ## indent ##
set autoindent
set smartindent
set smarttab
set expandtab
" for python pep8 (ts=tabstop; sts=softtabstop; sw=shiftwidth)
autocmd Filetype python setlocal ts=4 sts=4 sw=4


" PLUGIN CONFIGURATION

"### Deoplete ###
let g:deoplete#enable_at_startup = 1
" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" #### THEMES ####
colorscheme snow
" colorscheme neon
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='hybrid'

" Remove reduntant spaces at the end of the line with F7
autocmd BufWritePre * :%s/\s\+$//e
" Remove ^M at the end of the files save in windows
map  :%s/\r//g

" #### SpellChcek ####
"set spell spelllang=pt " Enable
"set spelllang=en
set nospell " Desable

" #### KEY MAPS ####

" vim-autoformat
noremap <F3> :Autoformat<CR>

" Tagbar map to F8
nmap <F8> :TagbarToggle<CR>

" ## ctrl + s for clean search ##
map <C-s> :noh<CR>

" ## nerdtree ##
map <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" Automatically close NERDTree when you open a file
let NERDTreeQuitOnOpen=1

" new buffer
nnoremap <C-b> :CtrlPBuffer<CR>

" buffer navagation
noremap <C-l> gt
noremap <C-h> gT

" ## move lines  - ctrl + j/k to up and down lines ##
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" ## automatically closes { ( [
imap { {}<Left>
imap ( ()<Left>
imap [ []<Left>
