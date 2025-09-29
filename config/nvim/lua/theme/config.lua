local config = {}

local defaults = {
    transparent = false,
    italic_comments = false,
    italic_inlayhints = false,
    underline_links = false,
    color_overrides = {},
    group_overrides = {},
    disable_nvimtree_bg = true,
    terminal_colors = true,
}

config.opts = {}

---@param user_opts? table
config.setup = function(user_opts)
    -- but override global vars settings with setup() settings
    config.opts = defaults

    -- setting transparent to true removes the default background
    if config.opts.transparent then
        config.opts.color_overrides.vscBack = 'NONE'
    end
end

-- initialize config
config.setup()

return config
