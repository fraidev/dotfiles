local g = vim.g
local fn = vim.fn
local utils = require("utils")
local nmap = utils.nmap
local env = vim.env

-- vim.cmd [[packadd packer.nvim]]
return require("packer").startup(
    function(use)
        use("lewis6991/impatient.nvim")
        -- a set of lua helpers that are used by other plugins
        use("nvim-lua/plenary.nvim")
        -- Packer can manage itself
        use("wbthomason/packer.nvim")

        -- spellsitter. Can remove this neovim 0.8
        use(
            {
                "lewis6991/spellsitter.nvim",
                config = function()
                    require("spellsitter").setup()
                end
            }
        )
        use {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            run = ":MasonUpdate" -- :MasonUpdate updates registry contents
        }

        -- colorscheme
        use("Mofiqul/vscode.nvim")

        use("dstein64/vim-startuptime")
        -- use("nathom/filetype.nvim")
        use({"gpanders/editorconfig.nvim", event = "BufRead"})
        use(
            {
                "ThePrimeagen/harpoon",
                config = function()
                    require("plugins.harpoon")
                end
            }
        )

        use("JoosepAlviste/nvim-ts-context-commentstring")
        use(
            {
                "folke/which-key.nvim",
                -- event = "VimEnter",
                config = function()
                    require("plugins.whichkey")
                end
            }
        )

        use(
            {
                "sindrets/winshift.nvim"
                -- event = "VimEnter",
            }
        )

        -- easy commenting
        use(
            {
                "tpope/vim-commentary",
                keys = {"gc", "gb"}
            }
        )

        -- fugitive
        use({"tpope/vim-fugitive", opt = true, event = "BufRead"})
        nmap("<leader>gr", ":Gread<cr>")
        nmap("<leader>gb", ":G blame<cr>")
        nmap("<leader>gg", ":Git<cr>")
        nmap("<leader>gi", ":Gedit:<cr>")
        nmap("<leader>gd", ":Gdiffsplit<cr>")

        -- vim-rooterinit
        -- use("airblade/vim-rooter")

        -- use devicons for filetypes
        use("nvim-tree/nvim-web-devicons")

        -- bufferline
        -- use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "nvim-tree/nvim-web-devicons" })

        -- lualine
        use(
            {
                "nvim-lualine/lualine.nvim",
                requires = {"nvim-tree/nvim-web-devicons", opt = true}
                -- config = function()
                -- 	require("plugins.lualine")
                -- end,
            }
        )

        -- spectre
        use(
            {
                "windwp/nvim-spectre",
                requires = {"nvim-tree/nvim-web-devicons", opt = true}
            }
        )

        -- general plugins
        -- emmet support for vim - easily create markdup wth CSS-like syntax
        use("mattn/emmet-vim")

        -- edit quickfix list
        use("itchyny/vim-qfedit")

        use("ekalinin/Dockerfile.vim")
        -- use "jparise/vim-graphql"

        use(
            {
                "kdheepak/lazygit.nvim"
                -- event = "VimEnter",
            }
        )

        use("hrsh7th/cmp-nvim-lsp-signature-help")
        use("hrsh7th/cmp-vsnip")
        use("hrsh7th/vim-vsnip")
        use("hrsh7th/vim-vsnip-integ")
        local snippet_dir = os.getenv("DOTFILES") .. "/config/nvim/snippets"
        g.vsnip_snippet_dir = snippet_dir
        g.vsnip_filetypes = {
            javascriptreact = {"javascript"},
            typescriptreact = {"typescript"},
            ["typescript.tsx"] = {"typescript"}
        }

        -- add color highlighting to hex values
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

        -- fast lau file drawer
        use(
            {
                "nvim-tree/nvim-tree.lua",
                -- cmd = { "NvimTreeToggle", "NvimTreeFocus" },
                -- event = "VimEnter",
                config = function()
                    require("plugins.nvimtree")
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

        -- Helpers to configure the built-in Neovim LSP client
        use("jose-elias-alvarez/nvim-lsp-ts-utils")

        -- Helpers to install LSPs and maintain them
        use("williamboman/nvim-lsp-installer")

        -- neovim completion
        use("hrsh7th/cmp-nvim-lsp")
        use("hrsh7th/cmp-buffer")
        use("hrsh7th/cmp-path")
        use("hrsh7th/cmp-cmdline")
        use("hrsh7th/nvim-cmp")
        use("kkharji/lspsaga.nvim")

        -- treesitter enables an AST-like understanding of files
        use(
            {
                "nvim-treesitter/nvim-treesitter",
                run = ":TSUpdate",
                config = function()
                    require("plugins.treesitter")
                end
            }
        )
        -- show nerd font icons for LSP types in completion menu
        use("onsails/lspkind-nvim")

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

        -- enable copilot support for Neovim
        use(
            "github/copilot.vim",
            {
                opt = true,
                event = "BufRead"
            }
        )
        -- if a copilot-aliased version of node exists from fnm, use that
        -- local copilot_node_path = env.FNM_DIR .. "/aliases/copilot/bin/node"
        -- if utils.file_exists(copilot_node_path) then
        --     g.copilot_node_path = copilot_node_path
        -- end
        -- improve the default neovim interfaces, such as refactoring
        use("stevearc/dressing.nvim")

        -- Navigate a code base with a really slick UI
        use("nvim-telescope/telescope.nvim")

        -- Startup screen for Neovim
        -- use(
        --     {
        --         "startup-nvim/startup.nvim",
        --         requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
        --         config = function()
        --             require("plugins.startup")
        --         end
        --     }
        -- )
        use("BurntSushi/ripgrep")

        -- Vim-illuminate - Vim plugin for automatically highlighting
        -- other uses of the current word under the cursor
        use({"RRethy/vim-illuminate", event = "BufRead"})

        -- use 'pocco81/auto-save.nvim'
        use(
            {
                "XXiaoA/auto-save.nvim",
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
                -- opt = true,
                -- event = "VimEnter",
                config = function()
                    require("plugins.floaterm")
                end
            }
        )

        -- OCaml
        use("ocaml/vim-ocaml")
        use({"tjdevries/ocaml.nvim", config = function()
            require("ocaml").setup()
        end})
        -- use 'jordwalke/vim-reasonml'
        -- use("nkrkv/nvim-treesitter-rescript")

        -- Rust
        use("simrat39/rust-tools.nvim")

        -- Go
        use({"fatih/vim-go", run = ":GoUpdateBinaries"})

        -- Nix
        use("LnL7/vim-nix")

        -- C#
        use("Hoffs/omnisharp-extended-lsp.nvim")
    end
)
