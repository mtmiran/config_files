local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting   -- formatting
local diagnostics = null_ls.builtins.diagnostics -- linter
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    sources = {
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
        formatting.stylua,       -- lua
        formatting.eslint,       -- javascript
        formatting.prettier,     -- html
        formatting.markdownlint, -- markdown
        formatting.black,        -- python3
        diagnostics.flake8,      -- python3
        formatting.shfmt,        -- bash
    },

    -- autosave formatting
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,

})
