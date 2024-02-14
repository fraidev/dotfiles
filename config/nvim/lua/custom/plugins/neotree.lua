-- Neo-tree
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim"
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    optional = false,
    config = function()
        local nnoremap = require("utils").nnoremap

        nnoremap("<leader>m", "<cmd>Neotree toggle<CR>")
        -- nnoremap("<leader>M", "<cmd>Neotree action=focus<CR>")

        require("neo-tree").setup {
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_pattern = {
                        "**/.vscode",
                        "**/node_modules",
                        "**/dist",
                        "**/build",
                        "**/_build",
                        "**/_opam",
                        "**/.git",
                        "**/.DS_Store"
                    }
                },
                follow_current_file = {
                    enabled = true
                },
                window = {
                    mappings = {
                        ["<bs>"] = "close_node",
                        ["!"] = "navigate_up",
                        ["/"] = "filter_on_submit"
                    }
                }
            },
            source_selector = {
                winbar = true,
                statusline = false
            }
        }
    end
}
