return {
    -- A set of lua helpers that are used by other plugins
    "nvim-lua/plenary.nvim",
    -- Plugin to show the startuptime of neovim using :StartupTime
    "dstein64/vim-startuptime",
    "gpanders/editorconfig.nvim",
    -- Neovim completion
    {
        "hrsh7th/nvim-cmp",
        "onsails/lspkind-nvim",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "kkharji/lspsaga.nvim",
        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load({paths = "./my_snippets"})
            end
        },
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets"
    },
    "JoosepAlviste/nvim-ts-context-commentstring",
    -- Use devicons for filetypes
    "nvim-tree/nvim-web-devicons",
    -- Add color highlighting to hex values
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end
    },
    -- Neoformat
    {
        "sbdchd/neoformat",
        config = function()
            vim.g.neoformat_cs_csharpier = {exe = "csharpier", args = {}, stdin = 1}
            vim.g.neoformat_rust_rustfmt = {exe = "rustfmt", args = {"--edition=2021"}, stdin = 1}
        end
    },
    -- Enable copilot support for Neovim
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_filetypes = {markdown = true, yml = true, yaml = true, mdx = true}
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
    "ocaml/vim-ocaml",
    -- Rust
    {
        "mrcjkb/rustaceanvim",
        version = "^4", -- Recommended
        lazy = false, -- This plugin is already lazy
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap"
        },
        config = function()
            vim.g.rustaceanvim = {
                inlay_hints = {
                    highlight = "NonText"
                },
                tools = {
                    float_win_config = {
                        border = "rounded"
                    },
                    hover_actions = {
                        auto_focus = true
                    }
                },
                server = {
                    default_settings = {
                        -- rust-analyzer language server configuration
                        ["rust-analyzer"] = {
                            imports = {
                                granularity = {
                                    group = "module"
                                },
                                prefix = "self"
                            },
                            cargo = {
                                loadOutDirsFromCheck = true,
                                buildScripts = {
                                    enable = true
                                }
                            },
                            checkOnSave = {allTargets = true, command = "clippy"},
                            -- checkOnSave = {
                            --     enable = false
                            -- },
                            procMacro = {
                                enable = true
                            }
                        }
                    }
                }
            }
        end
    },
    -- Go
    {"fatih/vim-go", build = ":GoUpdateBinaries"},
    {
        "folke/todo-comments.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = {}
    }
    -- {
    --     "nvim-neotest/neotest",
    --     dependencies = {
    --         "nvim-neotest/nvim-nio",
    --         "nvim-lua/plenary.nvim",
    --         "antoinemadec/FixCursorHold.nvim",
    --         "nvim-treesitter/nvim-treesitter"
    --     },
    --     config = function()
    --         require("neotest").setup {
    --             adapters = {
    --                 require("rustaceanvim.neotest")
    --             }
    --         }
    --     end
    -- }
}
