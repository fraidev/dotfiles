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
        "NvChad/nvim-colorizer.lua",
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
    -- Go
    {"fatih/vim-go", build = ":GoUpdateBinaries"},
    {
        "folke/todo-comments.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = {}
    }
}
