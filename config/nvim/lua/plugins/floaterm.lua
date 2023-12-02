local g = vim.g
local utils = require('utils')
local nnoremap = utils.nnoremap
local tnoremap = utils.tnoremap
local inoremap = utils.inoremap

g.floaterm_wintype = "split"
g.floaterm_width = 0.7

nnoremap('<F11>', ':FloatermNew<CR>')
tnoremap('<F11>', '<C-\\><C-n>:FloatermNew<CR>')
nnoremap('<F9>', ':FloatermPrev<CR>')
inoremap('<F9>', '<Esc>:FloatermPrev<CR>')
tnoremap('<F9>', '<C-\\><C-n>:FloatermPrev<CR>')
nnoremap('<F10>', ':FloatermNext<CR>')
inoremap('<F10>', '<Esc>:FloatermNext<CR>')
tnoremap('<F10>', '<C-\\><C-n>:FloatermPrev<CR>')
nnoremap('<F12>', ':FloatermToggle<CR>')
inoremap('<F12>', '<Esc>:FloatermToggle<CR>')
tnoremap('<F12>', '<C-\\><C-n>:FloatermToggle<CR>')
