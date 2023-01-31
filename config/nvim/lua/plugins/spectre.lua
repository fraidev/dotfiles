local nnoremap = require("utils").nnoremap

nnoremap("<leader>S", "<cmd>lua require('spectre').open()<CR>")
nnoremap("<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
nnoremap("<leader>s", "<esc>:lua require('spectre').open_visual()<CR>")
nnoremap("<leader>sp", "viw:lua require('spectre').open_file_search()<cr>")
