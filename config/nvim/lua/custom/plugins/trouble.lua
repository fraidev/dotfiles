-- Trouble
return {
    "folke/trouble.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        require("trouble").setup()
        local nnoremap = require("utils").nnoremap

        -- trouble keymappings
        nnoremap("<leader>xX", "<cmd>Trouble diagnostics toggle<cr>")
        nnoremap("<leader>xx", "<cmd>Telescope diagnostics previewer=false<cr>")
        -- nnoremap("<leader>xX", "<cmd>Telescope diagnostics bufnr=0 previewer=false<cr>")
        nnoremap("<leader>xw", "<cmd>Trouble diagnostics toggle<cr>")
        nnoremap("<leader>xq", "<cmd>Trouble qflist toggle<cr>")
        nnoremap("<leader>xl", "<cmd>Trouble loclist toggle<cr>")
        nnoremap("g2R", "<cmd>Trouble lsp_references<cr>")
    end
}
