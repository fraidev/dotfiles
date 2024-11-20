return {
    "NTBBloodbath/doom-one.nvim",
    config = function()
        local cmd = vim.cmd
        local g = vim.g
        vim.opt.termguicolors = true
	vim.g.high_contrast_theme = true
        g.doom_one_cursor_coloring = false
        g.doom_one_terminal_colors = true
        g.doom_one_italic_comments = false
        g.doom_one_enable_treesitter = true
        g.doom_one_plugin_telescope = false
        g.doom_one_plugin_nvim_tree = true
        g.doom_one_plugin_whichkey = true
        g.doom_one_plugin_vim_illuminate = true
        cmd("colorscheme doom-one")
        cmd("hi LineNr guifg=#5eacd3")
    end
}
