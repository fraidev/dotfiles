-- Neo-tree
return {
    -- "nvim-neo-tree/neo-tree.nvim",
    -- branch = "v3.x"
    "pysan3/neo-tree.nvim",
    branch = "restore-session-experimental",
    version = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        {
            "s1n7ax/nvim-window-picker",
            version = "2.*",
            config = function()
                require "window-picker".setup(
                    {
                        filter_rules = {
                            include_current_win = false,
                            autoselect_one = true,
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = {"neo-tree", "neo-tree-popup", "notify"},
                                -- if the buffer type is one of following, the window will be ignored
                                buftype = {"terminal", "quickfix"}
                            }
                        }
                    }
                )
            end
        }
    },
    optional = false,
    opts = {
        auto_restore_session_experimental = true
    },
    config = function()
        local nnoremap = require("utils").nnoremap
        nnoremap("<leader>m", "<cmd>Neotree toggle<CR>")
        -- nnoremap("<leader>M", "<cmd>Neotree action=focus<CR>")

        require("neo-tree").setup(
            {
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
                            ["<bs>"] = "navigate_up",
                            ["."] = "set_root",
                            ["H"] = "toggle_hidden",
                            ["/"] = "fuzzy_finder",
                            ["D"] = "fuzzy_finder_directory",
                            ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                            -- ["D"] = "fuzzy_sorter_directory",
                            ["f"] = "filter_on_submit",
                            ["<c-x>"] = "clear_filter",
                            ["[g"] = "prev_git_modified",
                            ["]g"] = "next_git_modified",
                            ["o"] = {"show_help", nowait = false, config = {title = "Order by", prefix_key = "o"}},
                            ["oc"] = {"order_by_created", nowait = false},
                            ["od"] = {"order_by_diagnostics", nowait = false},
                            ["og"] = {"order_by_git_status", nowait = false},
                            ["om"] = {"order_by_modified", nowait = false},
                            ["on"] = {"order_by_name", nowait = false},
                            ["os"] = {"order_by_size", nowait = false},
                            ["ot"] = {"order_by_type", nowait = false},
                            ["z"] = "none"
                        }
                    }
                },
                source_selector = {
                    winbar = true,
                    statusline = false
                }
            }
        )
    end
}
