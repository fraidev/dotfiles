return {
    -- A set of lua helpers that are used by other plugins
    "nvim-lua/plenary.nvim",
    -- Plugin to show the startuptime of neovim using :StartupTime
    "dstein64/vim-startuptime",
    "gpanders/editorconfig.nvim",
    {"JoosepAlviste/nvim-ts-context-commentstring", ft = {"typescript", "typescriptreact"}},
    -- Use devicons for filetypes
    "nvim-tree/nvim-web-devicons",
    -- Add color highlighting to hex values
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end
    },
    -- Improve the default neovim interfaces, such as refactoring
    "stevearc/dressing.nvim",
    -- Vim-illuminate - Vim plugin for automatically highlighting
    -- other uses of the current word under the cursor
    {"RRethy/vim-illuminate"},
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true
    },
    -- OCaml
    -- "ocaml/vim-ocaml",
    -- Rust
    {
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
        lazy = false, -- This plugin is already lazy
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap"
        },
        config = function()
            vim.g.rustaceanvim = {
                tools = {
                    executor = "toggleterm"
                },
                server = {
                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                runBuildScripts = true
                            },
                            procMacro = {
                                enable = true
                            },
                            inlayHints = {
                                lifetimeElisionHints = {
                                    enable = true,
                                    useParameterNames = true
                                }
                            }
                        }
                    }
                }
            }
            -- inlay_hints = {
            --     highlight = "NonText"
            -- },
            -- tools = {
            --     float_win_config = {
            --         border = "rounded"
            --     },
            --     hover_actions = {
            --         auto_focus = true
            --     }
            -- },
            -- server = {
            --     default_settings = {
            --         -- rust-analyzer language server configuration
            --         ["rust-analyzer"] = {
            --             imports = {
            --                 granularity = {
            --                     group = "module"
            --                 },
            --                 prefix = "self"
            --             },
            --             cargo = {
            --                 allFeatures = true,
            --                 loadOutDirsFromCheck = true,
            --                 buildScripts = {
            --                     enable = true
            --                 }
            --             },
            --             assist = {
            --                 importMergeBehavior = "last",
            --                 importPrefix = "by_self"
            --             },
            --             procMacro = {
            --                 enable = true
            --             }
            --         }
            --     }
            -- }
            -- }
        end
    },
    -- Go
    {"fatih/vim-go", build = ":GoUpdateBinaries"},
    {
        "folke/todo-comments.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = {}
    }
}
