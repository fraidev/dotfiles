return {
    -- A set of lua helpers that are used by other plugins
    "nvim-lua/plenary.nvim",
    -- Plugin to show the startuptime of neovim using :StartupTime
    "dstein64/vim-startuptime",
    "gpanders/editorconfig.nvim",
    -- Easy commenting
    -- {
    --     "tpope/vim-commentary",
    --     lazy = false
    -- },
    -- Neovim completion
    {
        "hrsh7th/nvim-cmp",
        "onsails/lspkind-nvim",
        "hrsh7th/vim-vsnip",
        "hrsh7th/vim-vsnip-integ",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "kkharji/lspsaga.nvim",
        "JoosepAlviste/nvim-ts-context-commentstring"
    },
    -- Use devicons for filetypes
    {
        "nvim-tree/nvim-web-devicons",
        optional = false,
        lazy = false
    },
    -- Lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons", "Mofiqul/vscode.nvim"},
        config = function()
            require("lualine").setup(
                {
                    options = {
                        theme = "vscode",
                        path = 3
                    }
                }
            )
        end
    },
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
    -- Telescope file browser
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"}
    },
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
                        max_width = 100,
                        max_height = 100
                    },
                    hover_actions = {
                        auto_focus = true
                    }
                }
            }
        end
    },
    -- Go
    {"fatih/vim-go", build = ":GoUpdateBinaries"},
    -- Trouble
    {
        "folke/trouble.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("trouble").setup()
            local nnoremap = require("utils").nnoremap

            -- trouble keymappings
            nnoremap("<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
            nnoremap("<leader>xw", "<cmd>Trouble diagnostics toggle<cr>")
            nnoremap("<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
            nnoremap("<leader>xq", "<cmd>Trouble qflist toggle<cr>")
            nnoremap("<leader>xl", "<cmd>Trouble loclist toggle<cr>")
            nnoremap("gR", "<cmd>Trouble lsp_references<cr>")
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = {}
    },
    "mfussenegger/nvim-dap",
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
        config = function()
            local nnoremap = require("utils").nnoremap
            require("dapui").setup()
            local dap, dapui = require("dap"), require("dapui")

            dap.adapters.lldb = {
                type = "server",
                host = "127.0.0.1",
                port = 13000,
                executable = {
                    -- CHANGE THIS to your path!
                    command = "/Users/frai/bin/codelldb", -- adjust as needed
                    args = {"--port", "13000"}
                }
            }
            dap.adapters.codelldb = {
                type = "server",
                host = "127.0.0.1",
                port = 13000,
                executable = {
                    -- CHANGE THIS to your path!
                    command = "/Users/frai/bin/codelldb", -- adjust as needed
                    args = {"--port", "13000"}
                }
            }

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            nnoremap("<F5>", "<cmd>lua require'dap'.continue()<cr>")
            nnoremap("<F6>", "<cmd>lua require'dap'.step_over()<cr>")
            nnoremap("<F7>", "<cmd>lua require'dap'.step_into()<cr>")
            nnoremap("<F8>", "<cmd>lua require'dap'.step_out()<cr>")
            nnoremap("<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
        end
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter"
        },
        config = function()
            require("neotest").setup {
                adapters = {
                    require("rustaceanvim.neotest")
                }
            }
        end
    }
    -- {
    --     "3rd/image.nvim",
    --     config = function()
    --         require("image").setup()
    --     end
    -- }
}
