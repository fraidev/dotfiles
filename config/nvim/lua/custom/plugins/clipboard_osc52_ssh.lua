-- OSC52 copy to clipboard ssh
return {
    "ojroques/nvim-osc52",
    config = function()
        if vim.env.SSH_TTY or vim.env.SSH_CLIENT or vim.env.SSH_CONNECTION then
            local function copy(lines, _)
                require("osc52").copy(table.concat(lines, "\n"))
            end

            local function paste()
                return {vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("")}
            end

            vim.g.clipboard = {
                name = "osc52",
                copy = {["+"] = copy, ["*"] = copy},
                paste = {["+"] = paste, ["*"] = paste}
            }
        end
    end
}
