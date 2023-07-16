vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true
vim.opt.textwidth=79

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.o.mouse = 'a'

vim.api.nvim_set_option("clipboard","unnamed")



-- TERMINAL SETUP
require("toggleterm").setup{
	direction = "horizontal",
	size = 15,
	open_mapping = [[<leader>j]]
}

-- Config for Markdown and LaTeX
local function get_file_extension()
  local file_name = vim.fn.expand('%:t')
  return vim.fn.fnamemodify(file_name, ':e')
end

-- Keybindings for linting and autoformatting
local file_extension = get_file_extension()
if file_extension == 'tex' then
  -- LaTeX settings and keybindings
  vim.g['vimtex_quickfix_mode'] = 0  -- Disable Quickfix mode (use Neovim's native LSP instead)

  vim.api.nvim_set_keymap('n', '<leader>mf', ':VimtexFormat<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ml', ':VimtexLint<CR>', { silent = true })
elseif file_extension == 'md' then
  -- Markdown settings and keybindings
  vim.g['vim_markdown_conceal'] = 0  -- Disable Markdown concealment
  vim.g['vim_markdown_conceal_code_blocks'] = 0  -- Disable concealment of code blocks
  vim.g['vim_markdown_math'] = 1  -- Enable rendering of math
  vim.g['vim_markdown_auto_insert_bullets'] = 0  -- Disable automatic bullet insertion
  vim.g['vim_markdown_folding_disabled'] = 1  -- Disable Markdown folding

  vim.api.nvim_set_keymap('n', '<leader>mf', ':MarkdownFormat<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ml', ':MarkdownLint<CR>', { silent = true })
end
