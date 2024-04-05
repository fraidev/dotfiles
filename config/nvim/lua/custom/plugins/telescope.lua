-- Navigate a code base with a really slick UI
return {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.5",
    dependencies = {{"nvim-lua/plenary.nvim"}},
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local nnoremap = require("utils").nnoremap

        telescope.setup(
            {
                pickers = {
                    find_files = {
                        theme = "ivy",
                        hidden = true
                    },
                    live_grep = {
                        theme = "ivy",
                        hidden = true
                    },
                    oldfiles = {
                        theme = "ivy"
                    },
                    buffers = {
                        theme = "ivy"
                    },
                    help_tags = {
                        theme = "ivy"
                    },
                    file_browser = {
                        theme = "ivy",
                        hidden = true
                    },
                    grep_string = {
                        theme = "ivy",
                        hidden = true
                    }
                },
                defaults = {
                    mappings = {
                        i = {
                            ["<Esc>"] = actions.close, -- don't go into normal mode, just close
                            ["<C-s>"] = actions.select_horizontal, -- open selection in new horizantal split
                            ["<C-v>"] = actions.select_vertical, -- open selection in new vertical split
                            ["<C-t>"] = actions.select_tab, -- open selection in new tab
                            ["<C-y>"] = actions.preview_scrolling_up,
                            ["<C-e>"] = actions.preview_scrolling_down
                        }
                    },
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    initial_mode = "insert",
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8
                        },
                        vertical = {
                            mirror = false
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 20
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
                    winblend = 0,
                    border = {},
                    -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    color_devicons = true,
                    use_less = true,
                    set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    -- Developer configurations: Not meant for general override
                    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                    preview = {
                        treesitter = false -- treesitter freezes on big files
                    }
                },
                extensions = {
                    file_browser = {
                        theme = "ivy",
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {
                            ["i"] = {},
                            ["n"] = {}
                        }
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = false,
                        override_file_sorter = true,
                        case_mode = "smart_case"
                    }
                }
            }
        )

        -- mappings
        nnoremap("<leader>e", "<cmd>Telescope find_files hidden=true<cr>", {desc = "Find files"})
        -- nnoremap("<leader>p", "<cmd>Telescope live_grep hidden=true<cr>", { desc = "Find in files" })
        vim.api.nvim_set_keymap(
            "n",
            "<leader>P",
            ':lua require"telescope.builtin".grep_string({ search = vim.fn.input("Grep For > ") })<CR>',
            {noremap = true, silent = true}
        )
        vim.api.nvim_set_keymap(
            "n",
            "<leader>p",
            ':lua require"telescope.builtin".live_grep({ hidden = true })<CR>',
            {noremap = true, silent = true}
        )
        -- vim.api.nvim_set_keymap("n", "<leader>p", ':lua require"telescope.builtin".grep_string()<CR>', { noremap = true, silent = true })
        nnoremap("<leader>k", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {desc = "File browser"})
        nnoremap(
            "<leader>K",
            "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
            {desc = "File browser (current file)"}
        )
        nnoremap("<leader>b", "<cmd>Telescope buffers<cr>")
        -- nnoremap("<leader>o", "<cmd>Telescope oldfiles<cr>")
        nnoremap("<leader>tt", "<cmd>Telescope<cr>")
        nnoremap("<leader>tn", "<cmd>Telescope node_modules list<cr>")
        -- nnoremap("<leader>tr", "<cmd>lua require('telescope').extensions.live_grep_raw.live_grep_raw()<cr>")
        nnoremap("<leader>tr", ':lua require("telescope.builtin").lsp_references()<CR>')
        nnoremap("<leader>te", "<cmd>Telescope find_files hidden=true <cr>")
        nnoremap("<leader>tp", "<cmd>Telescope live_grep hidden=true <cr>")
        nnoremap("<leader>th", "<cmd>Telescope help_tags<cr>")
    end
}
