-- Aliases -------------------------------------------------------------------
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

-- Packer setup --------------------------------------------------------------
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function()
    -- Commenting
    use 'tpope/vim-commentary'

    -- Syntax checking
    use 'vim-syntastic/syntastic'

    -- Formatter
    use 'Chiel92/vim-autoformat'
end)

-- Basic ---------------------------------------------------------------------
opt.backspace = 'indent,eol,start'
opt.backup = false
opt.swapfile = false
opt.undodir = 'undodir'
opt.undofile = true
opt.compatible = false
cmd('syntax on')
opt.modelines = 0
opt.encoding = 'utf-8'
opt.wrap = true
opt.confirm = true

-- Indentation and Tab -------------------------------------------------------
opt.softtabstop = 4
opt.shiftwidth = 4

-- Some for Python -----------------------------------------------------------
opt.textwidth = 79
cmd([[autocmd BufWritePre *.py :%s/\s\+$//e]])

-- Search and Highlighting ---------------------------------------------------
opt.path = ',.,**'
opt.hlsearch = true
opt.incsearch = true
opt.showmatch = true
opt.smartcase = true
cmd('highlight Cursorline cterm=bold ctermbg=black')

-- Display and Interface -----------------------------------------------------
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 10
opt.hidden = true
opt.ttyfast = true
opt.laststatus = 2
opt.showcmd = true

-- Colorscheme ---------------------------------------------------------------
if not fn.has('gui_running') then
    opt.t_Co = 256
end
opt.termguicolors = true
opt.background = 'dark'
cmd('colorscheme hybrid')

-- Vim-autoformat ------------------------------------------------------------
vim.api.nvim_set_keymap('n', '<F3>', [[:Autoformat<CR>]], { noremap = true, silent = true })


