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
        opts = {
            ensure_installed = {
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
            sync_install = true,
            indent = {enable = false},
            highlight = {
                enable = true
            }
        }
    }
}
