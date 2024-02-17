return {
    -- A set of lua helpers that are used by other plugins
    "nvim-lua/plenary.nvim",
    -- Plugin to show the startuptime of neovim using :StartupTime
    "dstein64/vim-startuptime",
    "gpanders/editorconfig.nvim",
    -- Easy commenting
    {
        "tpope/vim-commentary",
        lazy = false
    },
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
        end
    },
    -- Enable copilot support for Neovim
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_filetypes = {markdown = true, yml = true, yaml = true}
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
        ft = {"rust"}
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
            nnoremap("<leader>xx", "<cmd>TroubleToggle<cr>")
            nnoremap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
            nnoremap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
            nnoremap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
            nnoremap("<leader>xl", "<cmd>TroubleToggle loclist<cr>")
            nnoremap("gR", "<cmd>TroubleToggle lsp_references<cr>")
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
        dependencies = {"mfussenegger/nvim-dap"},
        config = function()
            require("dapui").setup()
            local dap, dapui = require("dap"), require("dapui")
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
        end
    }
}
