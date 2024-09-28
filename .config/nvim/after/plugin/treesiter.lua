require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "python", "c", "lua", "rust", "bash", "bibtex", "latex", "markdown" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- this part is only for if you installed nvim-ts-rainbow
    rainbow = {
        enable = true,
        extended_mode = true, -- adds rainbows for stuff like html tags
        max_file_lines = 2500 
        -- you can set this if you ever load big jsons into nvim 
        -- and just don't want to deal with it
        -- I've never written such a big code file before, 
        -- but I've had colleagues send me big monolithic files before, 
        -- otherwise I'd set this to something lower.
    }

}
