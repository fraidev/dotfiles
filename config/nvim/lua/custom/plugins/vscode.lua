-- Vscode Theme
return {
    "Mofiqul/vscode.nvim",
    optional = false,
    lazy = false,
    priority = 100,
    config = function()
        local g = vim.g
        local o = vim.o
        local cmd = vim.cmd

        o.background = "dark"
        g.vscode_italic_comment = true
        local c = require("vscode.colors")
        require("vscode").setup(
            {
                -- Enable transparent background
                -- transparent = true,

                -- Enable italic comment
                italic_comments = true,
                -- Disable nvim-tree background color
                disable_nvimtree_bg = true,
                -- Override colors (see ./lua/vscode/colors.lua)
                color_overrides = {
                    vscLineNumber = "#FFFFFF",
                    -- vscDiffRedDark = "#FF0000",
                    vscDiffRedLight = "#373D29"
                    -- vscSearchCurrent = "#FF0000",
                    -- vscSearch = "#FF0000",
                },
                -- Override highlight groups (see ./lua/vscode/theme.lua)
                group_overrides = {
                    -- this supports the same val table as vim.api.nvim_set_hl
                    -- use colors from this colorscheme by requiring vscode.colors!
                    Cursor = {fg = c.vscDarkBlue, bg = c.vscLightGreen}
                }
            }
        )

        require("vscode").load()

        -- make the highlighting of tabs and other non-text less annoying
        cmd([[highlight SpecialKey ctermfg=19 guifg=#333333]])
        cmd([[highlight NonText ctermfg=19 guifg=#333333]])
        cmd("hi LineNr guifg=#5eacd3")
        cmd("highlight ColorColumn ctermbg=0 guibg=grey")
        cmd("hi CursorLineNR guibg=none")
        cmd("hi CursorLine guibg=#333333")
        cmd("highlight netrwDir guifg=#5eacd3")
        cmd("highlight qfFileName guifg=#aed75f")
        cmd("hi TelescopeBorder guifg=#5eacd")
    end
}
