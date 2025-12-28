return {
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = {"nvim-tree/nvim-web-devicons"},
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "nvim-mini/mini.icons" },

        opts = {
            grep = {
                -- IMPORTANT: --column is what enables col jumps
                rg_opts = "--column --line-number --no-heading --color=always --smart-case"
            }
        },
        keys = function()
            return {
                {"<leader>e", "<cmd>FzfLua files<cr>", desc = "Find files"},
                {"<leader>p", "<cmd>FzfLua live_grep<cr>", desc = "Live grep"},
                {"<leader>P", "<cmd>FzfLua grep<cr>", desc = "Grep"},
                {"<leader>xx", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics"}
            }
        end
    }
}
