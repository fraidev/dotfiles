local g = vim.g
local api = vim.api

g.floaterm_wintype = "split"
-- vim.g.floaterm_height = 1.0
g.floaterm_width = 0.7

api.nvim_command([[
  nnoremap   <silent>   <F11>    :FloatermNew<CR>
  tnoremap   <silent>   <F11>    <C-\><C-n>:FloatermNew<CR>
  nnoremap   <silent>   <F8>    :FloatermPrev<CR>
  tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
  nnoremap   <silent>   <F9>    :FloatermNext<CR>
  inoremap   <silent>   <F9>   <esc>:FloatermNext<CR>
  nnoremap   <silent>   <F12>   :FloatermToggle<CR>
  inoremap   <silent>   <F12>   <esc>:FloatermToggle<CR>
  tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>
]])
