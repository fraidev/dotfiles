local configs = require("nvim-treesitter.configs")

configs.setup(
    {
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
            "rapper",
            "sql",
            "toml",
        },
        sync_install = false,
        indent = { enable = true },
        highlight = {
            enable = true,
            use_languagetree = true
        },
        context_commentstring = {
            enable = true
        },
        rainbow = {
            enable = false,
            extended_mode = false,
            max_file_lines = 1000
        }
    }
)
