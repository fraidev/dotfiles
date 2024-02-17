local utils = require("utils")
local nmap = utils.nmap
local nnoremap = utils.nnoremap

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
nnoremap("<Plug>WinMoveLeft", ':lua WinMove("h")<CR>')
nnoremap("<Plug>WinMoveDown", ':lua WinMove("j")<CR>')
nnoremap("<Plug>WinMoveUp", ':lua WinMove("k")<CR>')
nnoremap("<Plug>WinMoveRight", ':lua WinMove("l")<CR>')

nmap("<C-w>h", "<Plug>WinMoveLeft")
nmap("<C-w>j", "<Plug>WinMoveDown")
nmap("<C-w>k", "<Plug>WinMoveUp")
nmap("<C-w>l", "<Plug>WinMoveRight")

nmap("<C-h>", "<Plug>WinMoveLeft")
nmap("<C-j>", "<Plug>WinMoveDown")
nmap("<C-k>", "<Plug>WinMoveUp")
nmap("<C-l>", "<Plug>WinMoveRight")
