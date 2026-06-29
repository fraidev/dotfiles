-- This module is required at startup, so the top-level code below runs eagerly
-- while the plugin spec itself stays lazy. Copilot is loaded only on demand via
-- the `User CopilotLoad` event, so its language server (and the macOS keychain
-- prompt it triggers) never runs on plain nvim startup.
vim.keymap.set('n', '<leader>ce', function()
    vim.cmd('doautocmd User CopilotLoad')
    vim.cmd('Copilot enable')
end, { desc = 'Enable Copilot' })

return {
    -- Enable copilot support for Neovim
    {
        "github/copilot.vim",
        event = "User CopilotLoad",
        config = function()
            vim.g.copilot_filetypes = {markdown = true, yml = true, yaml = true, mdx = true}

	    vim.keymap.set('n', '<leader>cd', '<cmd>Copilot disable<cr>', { desc = 'Disable Copilot' })
        end
    }
}
