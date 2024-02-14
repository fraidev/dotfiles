-- Multicursors
return {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {"smoka7/hydra.nvim"},
    opts = {},
    cmd = {"MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor"},
    config = function()
        local utils = require("utils")
        local nnoremap = utils.nnoremap

        require("multicursors").setup {
            hint_config = {
                border = "rounded",
                position = "bottom-right"
            },
            generate_hints = {
                normal = true,
                insert = true,
                extend = true,
                config = {
                    column_count = 1
                }
            }
        }

        -- mappings
        nnoremap("<leader>i", "<cmd>MCstart<cr>")
    end
}
