vim.g.mapleader = " "

-- For Pandoc ----------------------------------------------------------------- 
-- Remap keys for commonly used actions
vim.api.nvim_set_keymap('n', '<Leader>cc', ':!pandoc -s % -o %.pdf<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>cm', ':!pandoc -s % -o %.docx<CR>', { noremap = true })
