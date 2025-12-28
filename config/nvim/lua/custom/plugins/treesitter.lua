-- Treesitter enables an AST-like understanding of files
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        opt = false,
        dependencies = {
            "HiPhish/rainbow-delimiters.nvim"
        },
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
                    "toml",
                    "zig"
                },
                -- sync_install = false,
                sync_install = true,
                indent = {enable = false},
                highlight = {
                    enable = true,
                    use_languagetree = true
                },
                -- context_commentstring = {
                --     enable = true
                -- },
                rainbow = {
                    enable = true,
                    disable = {"jsx", "cpp"},
                    -- Which query to use for finding delimiters
                    query = "rainbow-parens",
                    -- Highlight the entire buffer all at once
                    max_file_lines = 3000
                },
                fold = {
                    enable = true
                }
            }
        end
    }
}
