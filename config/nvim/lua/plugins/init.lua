local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        -- A set of lua helpers that are used by other plugins
        "nvim-lua/plenary.nvim",
        -- Mason lsp plugin
        {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            build = ":MasonUpdate" -- :MasonUpdate updates registry contents
        },
        -- Vscode Theme
        {
            "Mofiqul/vscode.nvim",
            config = function()
                require("plugins.vscode")
            end,
            optional = false,
            lazy = false
        },
        -- Plugin to show the startuptime of neovim using :StartupTime
        "dstein64/vim-startuptime",
        "gpanders/editorconfig.nvim",
        {
            "folke/which-key.nvim",
            config = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
                require("plugins.whichkey")
            end
        },
        -- Easy commenting

        {
            "tpope/vim-commentary",
            lazy = false,
            keys = {"gc", "gb"}
        },
        "JoosepAlviste/nvim-ts-context-commentstring",
        -- Fugitive
        {"tpope/vim-fugitive", optional = true},
        -- Use devicons for filetypes
        {
            "nvim-tree/nvim-web-devicons",
            lazy = false
        },
        -- Lualine
        {
            "nvim-lualine/lualine.nvim",
            dependencies = {"nvim-tree/nvim-web-devicons", "Mofiqul/vscode.nvim"},
            config = function()
                require("plugins.lualine")
            end
        },
        -- Spectre
        {
            "windwp/nvim-spectre",
            dependencies = {"nvim-tree/nvim-web-devicons"},
            config = function()
                require("plugins.spectre")
            end
        },
        {
            "kdheepak/lazygit.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim"
            }
        },
        -- Add color highlighting to hex values
        {
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("colorizer").setup()
            end
        },
        -- Show git information in the gutter
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("plugins.gitsigns")
            end
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
            config = function()
                -- require("plugins.completion")
            end
        },
        -- Treesitter enables an AST-like understanding of files
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("plugins.treesitter")
            end
        },
        -- Neoformat
        {
            "sbdchd/neoformat",
            config = function()
                require("plugins.neoformat")
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
        -- Navigate a code base with a really slick UI
        {
            "nvim-telescope/telescope.nvim",
            -- tag = "0.1.5",
            dependencies = {{"nvim-lua/plenary.nvim"}},
            config = function()
                require("plugins.telescope")
            end
        },
        -- Telescope file browser
        {
            "nvim-telescope/telescope-file-browser.nvim",
            dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"}
        },
        -- Vim-illuminate - Vim plugin for automatically highlighting
        -- other uses of the current word under the cursor
        {"RRethy/vim-illuminate"},
        {
            "pocco81/auto-save.nvim",
            config = function()
                require("plugins.autosave")
            end
        },
        {
            "akinsho/toggleterm.nvim",
            version = "*",
            config = true
            -- config = function()
            --     require("plugins.floaterm").setup()
            --     return true
            -- end
        },
        -- OCaml
        "ocaml/vim-ocaml",
        {
            "tjdevries/ocaml.nvim",
            config = function()
                require("ocaml").setup()
            end
        },
        -- Rust
        "simrat39/rust-tools.nvim",
        -- Go
        {"fatih/vim-go", build = ":GoUpdateBinaries"},
        -- Neo-tree
        {
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
                require("plugins.neotree")
            end
        },
        -- Multicursors
        {
            "smoka7/multicursors.nvim",
            event = "VeryLazy",
            dependencies = {"smoka7/hydra.nvim"},
            opts = {},
            cmd = {"MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor"},
            config = function()
                require("plugins.multicursors")
            end
        },
        -- OSC52 copy to clipboard ssh
        {
            "ojroques/nvim-osc52",
            config = function()
                require("plugins.clipboard_osc52_ssh")
            end
        },
        -- Trouble
        {
            "folke/trouble.nvim",
            dependencies = {"nvim-tree/nvim-web-devicons"},
            config = function()
                require("plugins.trouble")
            end
        },
        {
            "folke/todo-comments.nvim",
            dependencies = {"nvim-lua/plenary.nvim"},
            opts = {}
        }
    }
)
