-- Aliases -------------------------------------------------------------------
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

-- leader_key
g.mapleader = " "
g.maplocalleader = " "

-- Bootstrapping Lazy.nvim ---------------------------------------------------
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    fn.getchar()
    os.exit(1)
  end
end
opt.rtp:prepend(lazypath)

-- Load and configure plugins with lazy.nvim ----------------------------------
require("lazy").setup({
    { 'tpope/vim-commentary' },
    { 'jabirali/vim-tmux-yank' },

    -- Treesitter (Configuração moderna integrada no próprio setup do Lazy)
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            -- Nova forma de configurar no Treesitter recente
            require('nvim-treesitter').setup({
                ensure_installed = { "python", "lua", "javascript", "html", "css", "markdown", "markdown_inline", "latex" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Autocomplete (nvim-cmp)
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'L3MON4D3/LuaSnip' },
    { 'saadparwaiz1/cmp_luasnip' },

    -- LSP moderno para Neovim 0.12+
    { 'neovim/nvim-lspconfig' },
})

-- Basic ---------------------------------------------------------------------
opt.backspace = 'indent,eol,start'
opt.backup = false
opt.swapfile = false
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

-- Search and Highlighting ---------------------------------------------------
opt.path = ',.,**'
opt.hlsearch = true
opt.incsearch = true
opt.showmatch = true
opt.smartcase = true
cmd('highlight CursorLine guibg=gray')

-- Display and Interface -----------------------------------------------------
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 10
opt.hidden = true
opt.laststatus = 2
opt.showcmd = true

-- Colorscheme ---------------------------------------------------------------
if not fn.has('gui_running') then
    opt.termguicolors = true
end
opt.background = 'dark'
pcall(cmd, 'colorscheme hybrid')

-- telescope configuration ---------------------------------------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

-- nvim-cmp configuration --------------------------------------------------
local cmp = require('cmp')
cmp.setup({
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.close(),
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format('%s', vim_item.kind)
            return vim_item
        end,
    },
})

-- LSP Corrigido usando a nova API vim.lsp.config nativa do Neovim 0.12 -------
if vim.lsp.config then
    -- Jeito moderno do Neovim 0.12+
    vim.lsp.config('pyright', {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { ".git", "pyproject.toml", "setup.py" },
    })
    vim.lsp.enable('pyright')
else
    -- Fallback caso o lspconfig antigo ainda seja necessário
    require('lspconfig').pyright.setup({})
end

-- Mapeamentos globais do LSP comuns para o seu dia a dia
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { noremap = true, silent = true, buffer = args.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    end,
})

-- Markdown (Pandoc Auto-compile) --------------------------------------------
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.md",
  callback = function()
    local filename = vim.fn.expand("%:p")
    local pdfname = vim.fn.expand("%:p:r") .. ".pdf"
    local command = string.format("pandoc '%s' -o '%s' 2>/dev/null && evince '%s' &", filename, pdfname, pdfname)
    vim.fn.jobstart(command, { detach = true })
  end
})
