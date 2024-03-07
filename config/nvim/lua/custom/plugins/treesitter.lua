-- Treesitter enables an AST-like understanding of files
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opt = false,
    config = function()
        require "nvim-treesitter.configs".setup {
            ensure_installed = {
                -- "bash",
                "css",
                "html",
                "ocaml",
                "javascript",
                "lua",
                "python",
                "rust",
                "go",
                "typescript",
                "vim",
                "tsx",
                "json",
                "yaml",
                "sql",
                "toml"
            },
            sync_install = false,
            indent = {enable = true},
            highlight = {
                enable = true,
                use_languagetree = true
            },
            -- context_commentstring = {
            --     enable = true
            -- },
            rainbow = {
                enable = false,
                extended_mode = false,
                max_file_lines = 1000
            }
        }
    end
}
