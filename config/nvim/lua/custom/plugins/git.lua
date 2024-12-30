-- Show git information in the gutter
local utils = require("utils")
local nnoremap = utils.nnoremap
local nmap = utils.nmap
return {
    {
        "tpope/vim-fugitive",
        config = function()
            nnoremap("<leader>gr", ":Gread<cr>")
            nnoremap("<leader>gb", ":G blame<cr>")
            nnoremap("<leader>gg", ":Git<cr>")
            nnoremap("<leader>gi", ":Gedit:<cr>")
            nnoremap("<leader>gd", ":Gdiffsplit<cr>")
            nnoremap("<leader>gh", ":0Gclog<cr>")
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
            nnoremap("<leader>gp", ":Gitsigns preview_hunk<cr>")
            nnoremap("<leader>gt", ":Gitsigns toggle_current_line_blame<cr>")
        end
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            nmap("<leader>gl", ":LazyGit<cr>")
            nmap("<leader>gf", ":LazyGitFilter<cr>")
            nmap("<leader>gc", ":LazyGitFilterCurrentFile")
            nmap("<leader>lg", ":FloatermNew! git lg <cr>")
        end
    }
}
