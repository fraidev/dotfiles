local obsidian_path = vim.fn.expand("~/Obsidian/*.md")

return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
        "BufReadPre " .. obsidian_path,
        "BufNewFile " .. obsidian_path
    },
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/Obsidian/Frai/"
            }
        },
        daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = "Daily",
            -- Optional, if you want to change the date format for the ID of daily notes.
            date_format = "%Y-%m-%d",
            -- Optional, if you want to change the date format of the default alias of daily notes.
            alias_format = "%B %-d, %Y",
            -- Optional, default tags to add to each new daily note created.
            default_tags = {"daily-notes"},
            -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
            template = nil
        }
    }
}
