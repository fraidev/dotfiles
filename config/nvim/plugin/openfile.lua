vim.keymap.set(
    "n",
    "<leader>E",
    ":E ",
    {
        desc = "Edit file with line:col"
    }
)

vim.api.nvim_create_user_command(
    "E",
    function(opts)
        local f, l, c = opts.args:match("^(.-):(%d+):(%d+)$")
        if f then
            vim.cmd("edit " .. f)
            vim.api.nvim_win_set_cursor(0, {tonumber(l), tonumber(c)})
        else
            vim.cmd("edit " .. opts.args)
        end
    end,
    {nargs = 1, complete = "file"}
)
