-- Navigate a code base with a really slick UI
return {
    -- Telescope file browser
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"}
    },
    {
        "nvim-telescope/telescope.nvim",
        -- tag = "0.1.5",
        dependencies = {{"nvim-lua/plenary.nvim"}},
        config = function()
            local actions = require("telescope.actions")
            local data = assert(vim.fn.stdpath "data") --[[@as string]]
            local nnoremap = require("utils").nnoremap

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
                    }
                }
            }

            -- mappings
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "smart_history")
            pcall(require("telescope").load_extension, "ui-select")

            -- local builtin = require "telescope.builtin"
            -- vim.keymap.set(
            --     "n",
            --     "<space>en",
            --     function()
            --         builtin.find_files {cwd = vim.fn.stdpath "config"}
            --     end
            -- )
            nnoremap("<leader>e", "<cmd>Telescope find_files hidden=true<cr>", {desc = "Find files"})
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
}
