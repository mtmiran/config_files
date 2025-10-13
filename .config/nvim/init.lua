-- Aliases -------------------------------------------------------------------
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

-- Packer setup --------------------------------------------------------------
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Load and configure plugins with packer.nvim
require('packer').startup(function()
    -- Manage packer itself
    use 'wbthomason/packer.nvim'

    -- Commenting plugin
    use 'tpope/vim-commentary'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',  -- Automatically update parsers
    }

    -- vim-tmux-yank
    use 'jabirali/vim-tmux-yank'

    -- Autocomplete
    -- nvim-cmp and dependencies
    use 'hrsh7th/nvim-cmp'             -- Completion plugin
    use 'hrsh7th/cmp-nvim-lsp'         -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-buffer'           -- Buffer source for nvim-cmp
    use 'hrsh7th/cmp-path'             -- Path source for nvim-cmp
    use 'hrsh7th/cmp-cmdline'          -- Cmdline source for nvim-cmp
    use 'L3MON4D3/LuaSnip'             -- Snippet engine
    use 'saadparwaiz1/cmp_luasnip'     -- Snippet source for nvim-cmp

    -- LSP configurations
    use 'neovim/nvim-lspconfig'        -- LSP configurations
end)

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
cmd('highlight CursorLine guibg=gray') -- Changed to 'guibg' for GUI or 'ctermbg' for terminal

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
    opt.termguicolors = true -- Fix incorrect property name 't_Co'
end
opt.background = 'dark'
-- cmd('colorscheme hybrid')
cmd('colorscheme ayu')
-- cmd('colorscheme habamax')

-- nvim-cmp configuration --------------------------------------------------
local cmp = require('cmp')

cmp.setup({
    -- Define completion sources
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },       -- LSP source
        { name = 'luasnip' },        -- Snippets source
        { name = 'buffer' },         -- Buffer source
        { name = 'path' },           -- Path source
    }),

    -- Define key mappings for autocomplete
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.close(),
    },

    -- Define completion formatting
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format('%s', vim_item.kind) -- Show kind icon
            return vim_item
        end,
    },
})

-- LSP configuration --------------------------------------------------------
local lspconfig = require('lspconfig')

-- Example setup for Pyright LSP server
lspconfig.pyright.setup({
    on_attach = function(client, bufnr)
        -- Configure key mappings for LSP
        local opts = { noremap=true, silent=true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    end,
})


-- Treesitter configuration ------------------------------------------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "lua", "javascript", "html", "css",  "markdown", "latex" },  -- Install all maintained parsers
  highlight = {
    enable = true,                -- Enable syntax highlighting
    additional_vim_regex_highlighting = false, -- Disable additional Vim regex highlighting
  },
  indent = {
    enable = true,                -- Enable indentation based on Treesitter
  },
}

-- Markdown -----------------------------------------------------------------

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.md",
  callback = function()
    local filename = vim.fn.expand("%:p")
    local pdfname = vim.fn.expand("%:p:r") .. ".pdf"
    local command = string.format("pandoc '%s' -o '%s' 2>/dev/null && evince '%s' &", filename, pdfname, pdfname)
    vim.fn.jobstart(command, { detach = true })
  end
})


