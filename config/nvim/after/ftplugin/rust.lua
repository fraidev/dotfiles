-- Don't do comment stuffs when I use o/O
-- vim.opt_local.formatoptions:remove "o"

-- vim.lsp.enable("rust_analyzer")

-- vim.keymap.set("n", "<F5>", function()
--   if require("dap").session() then
--     require("dap").continue()
--   else
--     vim.cmd('DapNew')
--   end
-- end)

-- vim.lsp.inlay_hint.enable()
vim.g.rust_recommended_style = 0

if not vim.b.editorconfig then
    -- Find rustfmt.toml or .rustfmt.toml in the current project root
    local rustfmt_paths = {".rustfmt.toml", "rustfmt.toml"}
    local rustfmt_path = nil
    for _, file in ipairs(rustfmt_paths) do
        local fullpath = vim.fn.getcwd() .. "/" .. file
        if vim.fn.filereadable(fullpath) == 1 then
            rustfmt_path = fullpath
            break
        end
    end

    -- Default indentation fallback
    local tabstop = 4
    local shiftwidth = 4
    local expandtab = true
    local textwidth = 99

    -- If rustfmt.toml exists, parse `tab_spaces` and `max_width`
    if rustfmt_path then
        for line in io.lines(rustfmt_path) do
            local key, value = line:match("^%s*([%w_]+)%s*=%s*(%S+)")
            if key == "tab_spaces" then
                local num = tonumber(value)
                if num then
                    tabstop = num
                    shiftwidth = num
                end
            elseif key == "max_width" then
                local num = tonumber(value)
                if num then
                    textwidth = num
                end
            elseif key == "hard_tabs" then
                expandtab = (value ~= "true")
            end
        end
    end

    -- Apply local buffer settings
    vim.bo.tabstop = tabstop
    vim.bo.shiftwidth = shiftwidth
    vim.bo.softtabstop = shiftwidth
    vim.bo.expandtab = expandtab
    vim.bo.textwidth = textwidth
end

vim.g.rust_fold = 0
