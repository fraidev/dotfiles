-- Setup

return {
    "okuuva/auto-save.nvim",
    config = function()
        require("auto-save").setup(
            {
                enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
                trigger_events = {
                    immediate_save = {"BufLeave", "FocusLost"}, -- vim events that trigger an immediate save
                    defer_save = {"InsertLeave", "TextChanged"}, -- vim events that trigger a deferred save (saves after `debounce_delay`)
                    cancel_deferred_save = {"InsertEnter"} -- vim events that cancel a pending deferred save
                },
                -- function that determines whether to save the current buffer or not
                -- return true: if buffer is ok to be saved
                -- return false: if it's not ok to be saved
                condition = function(buf)
                    local fn = vim.fn
                    local utils = require("auto-save.utils.data")
                    if
                        utils.not_in(fn.getbufvar(buf, "&modifiable"), {1}) and
                            utils.not_in(fn.getbufvar(buf, "&buftype"), {"nofile"})
                     then
                        return true
                    end
                    if utils.not_in(fn.getbufvar(buf, "&filetype"), {"harpoon"}) then
                        return true
                    end

                    return false -- can't save
                end,
                write_all_buffers = true, -- write all buffers when the current one meets `condition`
                noautocmd = false, -- do not execute autocmds when saving
                lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
                debounce_delay = 135, -- saves the file at mos
                -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
                debug = false -- print debug messages, set to `true` to enablet every `debounce_delay` milliseconds
            }
        )
    end
}
