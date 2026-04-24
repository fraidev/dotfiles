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
            local parsers = {
                "css",
                "html",
                "ocaml",
                "javascript",
                "lua",
                "python",
                "rust",
                "go",
                "gomod",
                "gosum",
                "gowork",
                "typescript",
                "vim",
                "vimdoc",
                "tsx",
                "json",
                "yaml",
                "sql",
                "toml",
                "zig",
                "bash",
                "markdown",
                "markdown_inline"
            }

            require("nvim-treesitter").install(parsers)

            local ft_to_lang = {
                javascript = "javascript",
                typescript = "typescript",
                typescriptreact = "tsx",
                javascriptreact = "javascript"
            }

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("UserTreesitterStart", {clear = true}),
                callback = function(ev)
                    local ft = vim.bo[ev.buf].filetype
                    local lang = ft_to_lang[ft] or ft
                    pcall(vim.treesitter.start, ev.buf, lang)
                end
            })
        end
    }
}
