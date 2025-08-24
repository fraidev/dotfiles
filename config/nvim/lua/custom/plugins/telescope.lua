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
            "kkharji/sqlite.lua"
        },
        cmd = "Telescope",
        keys = {
            -- Lazy-load on specific keybindings
            {"<leader>e", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find files"},
            {
                "<leader>P",
                ':lua require"telescope.builtin".grep_string({ search = vim.fn.input("Grep For > ") })<CR>',
                desc = "Grep string"
            },
            {"<leader>p", ':lua require"telescope.builtin".live_grep({ hidden = true })<CR>', desc = "Live grep"},
            {"<leader>n", ":Telescope file_browser path=%:p:h select_buffer=true <CR>", desc = "File browser"},
            {"<leader>b", "<cmd>Telescope buffers<cr>", desc = "List buffers"},
            {"<leader>tt", "<cmd>Telescope<cr>", desc = "Open Telescope"},
            {"<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Help tags"}
        },
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
                        -- "build/",
                        "env/",
                        "gradle/",
                        "node_modules/",
                        "smalljre_*/*",
                        "target/",
                        "vendor/*",
                        "%.min.js"
                    },
                    find_command = {"fd", "--type", "f", "--hidden"},
                    vimgrep_arguments = {
                        "rg",
                        "--hidden",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case"
                    },
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    path_display = {"truncate"},
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
                },
                extensions = {
                    wrap_results = true,
                    fzf = {},
                    history = {
                        path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
                        limit = 100
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    },
                    file_browser = {
                        theme = "ivy"
                    }
                }
            }

            -- mappings
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "smart_history")
            pcall(require("telescope").load_extension, "ui-select")
            pcall(require("telescope").load_extension, "file_browser")
        end
    }
}
