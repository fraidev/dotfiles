local nvimtree = require("nvim-tree")
local nnoremap = require("utils").nnoremap

_G.NvimTreeConfig = {}

nnoremap("<leader>m", ":NvimTreeToggle<CR>")

nvimtree.setup(
    {
        disable_netrw = false,
        hijack_netrw = true,
        diagnostics = {
            enable = false
        },
        update_focused_file = {
            enable = true,
            update_cwd = false
        },
        git = {
            enable = true,
            ignore = false
        },
        view = {
            side = "left"
        }
    }
)
