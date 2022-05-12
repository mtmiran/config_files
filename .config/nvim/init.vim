"#########################
"#            _
"# _ ____   _(_)_ __ ___
"#| '_ \ \ / / | '_ ` _ \
"#| | | \ V /| | | | | | |
"#|_| |_|\_/ |_|_| |_| |_|
"#
"#########################

" ## GENERAL ##
set title		" Set title of document
set mouse=a		" enable mouse
syntax on		" enable syntax
set scrolloff=8		" Minimum number of lines to keep above and below the cursor
set number		" Show line numbers
set relativenumber	" Show line relative numbers
set linebreak		" Break lines at word (requires Wrap lines)
set textwidth=79	" Line wrap (number of cols)
set showmatch		" Highlight matching brace {} [] ()
set list lcs=trail:·,tab:»·

" ## search ##
set hlsearch		" Highlight all search results
set smartcase		" Enable smart-case search
set ignorecase		" Always case-insensitive
set incsearch		" Searches for strings incrementally

" ## indent ##
set autoindent		" Auto-indent new lines
set shiftwidth=4	" Number of auto-indent spaces
set smartindent		" Enable smart-indent
set smarttab		" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab

" ## editor behavior ##
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
set noswapfile		" No backup swapfile
set nobackup		" No backup files
set nowritebackup	" No backuo files
set clipboard=unnamedplus
set encoding=utf-8	" The conding should be utf-8 to activate the fonr icons
set splitright		" Create the vertical split to the right
set splitbelow		" Create the horizontal splits blelow
set cmdheight=2		" Give more space for displaying messages
set autoread		" Update nvim after file update from outside
filetype on		" Detect and set the filetype option and trigger the FileType Event
filetype plugin on	" Load the plugin file for the file type, if any
filetype indent on	" Load the indent file for the file type, if any


" #### PLUGINS ####
"" Plugs - :source % ; :PlugInstal ; remover: :PlugClean
call plug#begin()
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation

" NerdTree
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Auto Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

" Formater
Plug 'Chiel92/vim-autoformat'

" Themes
Plug 'rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'rafamadriz/themes.nvim'

call plug#end()


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
"set spell spelllang=pt	" Enable
"set spelllang=en
set nospell		" Desable

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
