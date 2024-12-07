-- Neovim completion
return {
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
}
