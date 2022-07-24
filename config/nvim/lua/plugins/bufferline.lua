
local bufferline = require("bufferline")
local nnoremap = require("utils").nnoremap


bufferline.setup(
    {
    }
)

nnoremap ("<Tab>", ":BufferLineCycleNext<CR>")
nnoremap ("<S-Tab>", ":BufferLineCyclePrev<CR>")

