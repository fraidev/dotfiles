return {
    -- Enable copilot support for Neovim
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_filetypes = {markdown = true, yml = true, yaml = true, mdx = true}
        end
    }
}
