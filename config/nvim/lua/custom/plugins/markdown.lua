return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            completions = {lsp = {enabled = true}},
            heading = {
                -- Keep the raw '#', '##', ... markers instead of replacing them.
                icons = {},
                sign = false,
                backgrounds = {}
            }
        },
        keys = {
            {"<leader>tr", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle render markdown"}
        }
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = ":call mkdp#util#install_sync()",
        config = function()
            vim.g.mkdp_filetypes = {"markdown"}
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_theme = "dark"
        end,
        keys = {
            {"<leader>tp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown preview"}
        }
    }
}
