return require("packer").startup(
    function(use)
        use("lewis6991/impatient.nvim")
        -- A set of lua helpers that are used by other plugins
        use("nvim-lua/plenary.nvim")
        -- Packer can manage itself
        use("wbthomason/packer.nvim")
        -- Mason lsp plugin
        use {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            run = ":MasonUpdate" -- :MasonUpdate updates registry contents
        }
        -- Vscode Theme
        use(
            {
                "Mofiqul/vscode.nvim",
                config = function()
                    require("plugins.vscode")
                end
            }
        )
        -- Plugin to show the startuptime of neovim using :StartupTime
        use("dstein64/vim-startuptime")
        use({"gpanders/editorconfig.nvim", event = "BufRead"})
        use(
            {
                "folke/which-key.nvim",
                config = function()
                    vim.o.timeout = true
                    vim.o.timeoutlen = 300
                    require("plugins.whichkey")
                end
            }
        )

        -- Easy commenting
        use(
            {
                "tpope/vim-commentary",
                keys = {"gc", "gb"}
            }
        )

        -- Fugitive
        use({"tpope/vim-fugitive", opt = true, event = "BufRead"})

        -- Use devicons for filetypes
        use("nvim-tree/nvim-web-devicons")

        -- Lualine
        use {
            "nvim-lualine/lualine.nvim",
            requires = {"nvim-tree/nvim-web-devicons"},
            config = function()
                require("plugins.lualine")
            end
        }

        -- Spectre
        use(
            {
                "windwp/nvim-spectre",
                requires = {"nvim-tree/nvim-web-devicons"},
                config = function()
                    require("plugins.spectre")
                end
            }
        )

        -- Emmet support for vim - easily create markdup wth CSS-like syntax
        use("mattn/emmet-vim")

        use("kdheepak/lazygit.nvim")

        -- Add color highlighting to hex values
        use(
            {
                "norcalli/nvim-colorizer.lua",
                event = "BufRead",
                opt = true,
                config = function()
                    require("colorizer").setup()
                end
            }
        )

        -- Show git information in the gutter
        use(
            {
                "lewis6991/gitsigns.nvim",
                opt = true,
                event = "BufRead",
                config = function()
                    require("plugins.gitsigns")
                end
            }
        )

        -- Neovim completion
        use(
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
            }
        )
        -- Treesitter enables an AST-like understanding of files
        use(
            {
                "nvim-treesitter/nvim-treesitter",
                run = ":TSUpdate",
                config = function()
                    require("plugins.treesitter")
                end
            }
        )

        -- Neoformat
        use(
            {
                "sbdchd/neoformat",
                event = "BufRead",
                opt = true,
                config = function()
                    require("plugins.neoformat")
                end
            }
        )

        -- Enable copilot support for Neovim
        use(
            "github/copilot.vim",
            {
                opt = true,
                event = "BufRead",
                config = function()
                    vim.g.copilot_filetypes = {markdown = true, yml = true, yaml = true}
                end
            }
        )
        -- Improve the default neovim interfaces, such as refactoring
        use("stevearc/dressing.nvim")

        -- Navigate a code base with a really slick UI
        use {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.5",
            requires = {{"nvim-lua/plenary.nvim"}},
            config = function()
                require("plugins.telescope")
            end
        }

        -- Telescope file browser
        use {
            "nvim-telescope/telescope-file-browser.nvim",
            requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"}
        }

        -- Vim-illuminate - Vim plugin for automatically highlighting
        -- other uses of the current word under the cursor
        use({"RRethy/vim-illuminate", event = "BufRead"})

        use(
            {
                "pocco81/auto-save.nvim",
                opt = true,
                event = "BufRead",
                config = function()
                    require("plugins.autosave")
                end
            }
        )

        -- Floaterm
        use(
            {
                "voldikss/vim-floaterm",
                config = function()
                    require("plugins.floaterm")
                end
            }
        )

        -- OCaml
        use("ocaml/vim-ocaml")
        use(
            {
                "tjdevries/ocaml.nvim",
                config = function()
                    require("ocaml").setup()
                end
            }
        )

        -- Rust
        use("simrat39/rust-tools.nvim")

        -- Go
        use({"fatih/vim-go", run = ":GoUpdateBinaries"})

        -- Neo-tree
        use {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim"
            },
            config = function()
                require("plugins.neotree")
            end
        }
        -- Multicursors
        use(
            {
                "smoka7/multicursors.nvim",
                requires = {"smoka7/hydra.nvim"},
                config = function()
                    require("plugins.multicursors")
                end
            }
        )

        -- OSC52 copy to clipboard ssh
        use(
            {
                "ojroques/nvim-osc52",
                config = function()
                    require("plugins.clipboard_osc52_ssh")
                end
            }
        )

        -- Trouble
        use(
            {
                "folke/trouble.nvim",
                requires = {"nvim-tree/nvim-web-devicons"},
                config = function()
                    require("plugins.trouble")
                end
            }
        )
    end
)
