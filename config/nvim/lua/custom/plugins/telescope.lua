-- Navigate a code base with a really slick UI
return {
    -- Telescope file browser
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {"nvim-telescope/telescope.nvim"}, -- Ensure the main plugin is loaded
        lazy = true -- Lazy-load with Telescope
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "master",
        dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-telescope/telescope-fzf-native.nvim", build = "make"},
            "nvim-telescope/telescope-smart-history.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-frecency.nvim",
            "kkharji/sqlite.lua"
        },
        cmd = "Telescope",
        keys = function()
            local multi_grep = function(opts)
                opts = opts or {}
                opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
                opts.shortcuts =
                    opts.shortcuts or
                    {
                        ["l"] = "*.lua",
                        ["v"] = "*.vim",
                        ["n"] = "*.{vim,lua}",
                        ["c"] = "*.c",
                        ["r"] = "*.rs",
                        ["g"] = "*.go"
                    }
                opts.pattern = opts.pattern or "%s"

                local conf = require("telescope.config").values
                local finders = require "telescope.finders"
                local make_entry = require "telescope.make_entry"
                local pickers = require "telescope.pickers"
                local flatten = vim.tbl_flatten

                local custom_grep =
                    finders.new_async_job {
                    command_generator = function(prompt)
                        if not prompt or prompt == "" then
                            return nil
                        end

                        local prompt_split = vim.split(prompt, "  ")

                        local args = {"rg"}
                        if prompt_split[1] then
                            table.insert(args, "-e")
                            table.insert(args, prompt_split[1])
                        end

                        if prompt_split[2] then
                            table.insert(args, "-g")

                            local pattern
                            if opts.shortcuts[prompt_split[2]] then
                                pattern = opts.shortcuts[prompt_split[2]]
                            else
                                pattern = prompt_split[2]
                            end

                            table.insert(args, string.format(opts.pattern, pattern))
                        end

                        return flatten {
                            args,
                            {
                                "--color=never",
                                "--no-heading",
                                "--with-filename",
                                "--line-number",
                                "--column",
                                "--smart-case"
                            }
                        }
                    end,
                    entry_maker = make_entry.gen_from_vimgrep(opts),
                    cwd = opts.cwd
                }

                pickers.new(
                    opts,
                    {
                        debounce = 100,
                        prompt_title = "Live Grep (with shortcuts)",
                        finder = custom_grep,
                        previewer = conf.grep_previewer(opts),
                        sorter = require("telescope.sorters").empty()
                    }
                ):find()
            end

            local frecency = function(opts)
                opts = opts or {}
                require("telescope").extensions.frecency.frecency {
                    workspace = "CWD",
                    show_scores = true,
                    show_unindexed = true,
                    ignore_patterns = {"*.git/*", "*/tmp/*", "*.jpg", "*.png", "*.svg", "*.exe", "*.dll"},
                    debounce = 50
                }
            end

            return {
                -- Lazy-load on specific keybindings
                {"<leader>E", "<cmd>Telescope frecency  workspace=CWD<cr>"},
                -- {"<leader>e", frecency, desc = "Frecency"},
                {"<leader>e", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find files"},
                -- {"<leader>g", "<cmd>Telescope git_files<cr>", desc = "Git files"},
                {
                    "<leader>P",
                    ':lua require"telescope.builtin".grep_string({ search = vim.fn.input("Grep For > ") })<CR>',
                    desc = "Grep string"
                },
                {"<leader>F", ':lua require"telescope.builtin".live_grep({ hidden = true })<CR>', desc = "Live grep"},
                {"<leader>p", multi_grep, desc = "Grep (with shortcuts)"},
                {"<leader>n", ":Telescope file_browser path=%:p:h select_buffer=true <CR>", desc = "File browser"},
                {"<leader>b", "<cmd>Telescope buffers<cr>", desc = "List buffers"},
                {"<leader>tt", "<cmd>Telescope<cr>", desc = "Open Telescope"},
                {"<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Help tags"}
            }
        end,
        config = function()
            local actions = require("telescope.actions")
            local data = assert(vim.fn.stdpath "data") --[[@as string]]

            require("telescope").setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<Esc>"] = actions.close -- don't go into normal mode, just close
                        }
                    },
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    file_ignore_patterns = {
                        "%.7z",
                        "%.JPEG",
                        "%.JPG",
                        "%.MOV",
                        "%.RAF",
                        "%.burp",
                        "%.bz2",
                        "%.cache",
                        "%.class",
                        "%.dll",
                        "%.docx",
                        "%.dylib",
                        "%.epub",
                        "%.exe",
                        "%.flac",
                        "%.ico",
                        "%.ipynb",
                        "%.jar",
                        "%.jpeg",
                        "%.jpg",
                        "%.lock",
                        "%.mkv",
                        "%.mov",
                        "%.mp4",
                        "%.otf",
                        "%.pdb",
                        "%.pdf",
                        "%.png",
                        "%.rar",
                        "%.sqlite3",
                        "%.svg",
                        "%.tar",
                        "%.tar.gz",
                        "%.ttf",
                        "%.webp",
                        "%.zip",
                        ".git/",
                        ".gradle/",
                        ".idea/",
                        ".settings/",
                        ".vale/",
                        ".vscode/",
                        "__pycache__/*",
                        "build/",
                        "env/",
                        "gradle/",
                        "node_modules/",
                        "smalljre_*/*",
                        "target/",
                        "vendor/*",
                        "%.min.js"
                    },
                    -- find_command = {"fd", "--type", "f", "--hidden"},
                    find_command = {"fd", "--type", "f"},
                    vimgrep_arguments = {
                        "rg",
                        "--hidden",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case"
                    }
                    -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    -- path_display = {"truncate"},
                    -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    -- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    -- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    -- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
                },
                extensions = {
                    wrap_results = true,
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    -- fzf = {},
                    -- history = {
                    --     path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
                    --     limit = 100
                    -- },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                    -- file_browser = {
                    --     theme = "ivy"
                    -- }
                }
            }

            -- mappings
            pcall(require("telescope").load_extension, "fzf")
            -- pcall(require("telescope").load_extension, "smart_history")
            pcall(require("telescope").load_extension, "ui-select")
            pcall(require("telescope").load_extension, "file_browser")
            pcall(require("telescope").load_extension, "frecency")
        end
    }
}
