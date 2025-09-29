return {
    -- Enable copilot support for Neovim
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_enabled = false
            vim.g.copilot_filetypes = {markdown = true, yml = true, yaml = true, mdx = true}

	    vim.keymap.set('n', '<leader>ce', '<cmd>Copilot enable<cr>', { desc = 'Enable Copilot' })
	    vim.keymap.set('n', '<leader>cd', '<cmd>Copilot disable<cr>', { desc = 'Disable Copilot' })
        end
    }
}
