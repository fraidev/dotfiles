-- Big-file / long-line guard.
-- Pasting or opening huge JSON (multi-MB, 100KB+ single lines) freezes nvim:
-- matchparen searches the whole buffer per bracket, line-wrap is recomputed on
-- a 400KB line every edit, treesitter parses synchronously, auto-save rewrites
-- the file on every TextChanged. Disable all of that for offending buffers.

local MAX_FILESIZE = 1024 * 1024 -- 1 MB
local MAX_LINELEN = 20000        -- chars on a single line

local function neuter(buf)
    if not vim.api.nvim_buf_is_valid(buf) or vim.b[buf].bigfile_guard then
        return
    end
    vim.b[buf].bigfile_guard = true

    pcall(vim.treesitter.stop, buf)
    vim.g._ts_force_sync_parsing = false -- global footgun set in options.lua

    vim.api.nvim_buf_call(buf, function()
        vim.cmd("setlocal syntax=off")
        vim.cmd("setlocal nowrap nolinebreak")
        vim.cmd("setlocal foldmethod=manual")
        vim.cmd("setlocal synmaxcol=200")
        vim.opt_local.spell = false
        vim.opt_local.cursorline = false
        vim.opt_local.list = false
        pcall(vim.cmd, "NoMatchParen") -- matchparen is global
    end)

    vim.b[buf].auto_save = false
    pcall(function() require("auto-save").off() end)

    vim.notify("bigfile guard active: TS/syntax/wrap/matchparen/auto-save off", vim.log.levels.WARN)
end

local function has_long_line(buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, 200, false)
    for _, l in ipairs(lines) do
        if #l > MAX_LINELEN then
            return true
        end
    end
    return false
end

local function check(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
        return
    end
    local name = vim.api.nvim_buf_get_name(buf)
    local ok, stat = pcall(vim.uv.fs_stat, name)
    if (ok and stat and stat.size > MAX_FILESIZE) or has_long_line(buf) then
        neuter(buf)
    end
end

local grp = vim.api.nvim_create_augroup("BigFileGuard", { clear = true })

-- catch huge files before they are read/highlighted
vim.api.nvim_create_autocmd("BufReadPre", {
    group = grp,
    callback = function(ev)
        local ok, stat = pcall(vim.uv.fs_stat, ev.match)
        if ok and stat and stat.size > MAX_FILESIZE then
            neuter(ev.buf)
        end
    end,
})

-- catch pasted content / long lines in any buffer
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufReadPost", "TextChanged" }, {
    group = grp,
    callback = function(ev)
        check(ev.buf)
    end,
})
