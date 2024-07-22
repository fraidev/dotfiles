return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300

        require("which-key").setup(
            {
                icons = {
                    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                    separator = "  ", -- symbol used between a key and it's label
                    group = "+" -- symbol prepended to a group
                },
                layout = {
                    spacing = 6 -- spacing between columns
                }
            }
        )
    end
}
