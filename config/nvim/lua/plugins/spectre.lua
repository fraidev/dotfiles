local nnoremap = require("utils").nnoremap
local vnoremap = require("utils").vnoremap

vnoremap("<leader>r", "<esc>:lua require('spectre').open_file_search()<CR>", {desc = "Search on current file"})
vnoremap("<leader>R", "<esc>:lua require('spectre').open_visual()<CR>", {desc = "Search current word"})
nnoremap(
    "<leader>r",
    "<cmd>lua require('spectre').open_file_search({select_word = true})<CR>",
    {desc = "Search on current file"}
)
nnoremap(
    "<leader>R",
    "<cmd>lua require('spectre').open_visual({select_word = true})<CR>",
    {desc = "Search current word"}
)
