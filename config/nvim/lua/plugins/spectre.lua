local nnoremap = require("utils").nnoremap
local xnoremap = require("utils").xnoremap

nnoremap("<leader>R", "<cmd>lua require('spectre').open()<CR>")
nnoremap("<leader>rw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
nnoremap("<leader>r", "<esc>:lua require('spectre').open_visual()<CR>")
xnoremap("<leader>r", "<esc>:lua require('spectre').open_visual()<CR>")
nnoremap("<leader>rp", "viw:lua require('spectre').open_file_search()<cr>")
