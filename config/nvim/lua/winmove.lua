function WinMove(key)
    local curwin = vim.fn.winnr()
    vim.cmd("wincmd " .. key)
    if curwin == vim.fn.winnr() then
        if string.match(key, "[jk]") then
            vim.cmd("wincmd s")
        else
            vim.cmd("wincmd v")
        end
        vim.cmd("wincmd " .. key)
    end
end

-- Define key mappings
vim.api.nvim_set_keymap("n", "<Plug>WinMoveLeft", ':lua WinMove("h")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Plug>WinMoveDown", ':lua WinMove("j")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Plug>WinMoveUp", ':lua WinMove("k")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Plug>WinMoveRight", ':lua WinMove("l")<CR>', {noremap = true, silent = true})
