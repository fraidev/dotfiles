-- Mason lsp plugin
return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local cmd = vim.cmd
            local api = vim.api
            local lsp = vim.lsp
            local theme = require("theme")
            local colors = theme.colors
            local icons = theme.icons

            -- Lsp Installer
            require("mason").setup(
                {
                    automatic_installation = true
                }
            )

            require("mason-lspconfig").setup()

            cmd("autocmd ColorScheme * highlight NormalFloat guibg=" .. colors.bg)
            cmd("autocmd ColorScheme * highlight FloatBorder guifg=white guibg=" .. colors.bg)

            local border = {
                {"🭽", "FloatBorder"},
                {"▔", "FloatBorder"},
                {"🭾", "FloatBorder"},
                {"▕", "FloatBorder"},
                {"🭿", "FloatBorder"},
                {"▁", "FloatBorder"},
                {"🭼", "FloatBorder"},
                {"▏", "FloatBorder"}
            }

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- _G makes this function available to vimscript lua calls
            _G.lsp_organize_imports = function()
                local params = {
                    command = "_typescript.organizeImports",
                    arguments = {api.nvim_buf_get_name(0)},
                    title = ""
                }
                lsp.buf.execute_command(params)
            end

            -- show diagnostic line with custom border and styling
            _G.lsp_show_diagnostics = function()
                vim.diagnostic.open_float({border = border})
            end

            vim.keymap.set("n", "<leader>od", vim.diagnostic.open_float)
            vim.keymap.set("n", "[a", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]a", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

            vim.api.nvim_create_autocmd(
                "LspAttach",
                {
                    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                    callback = function(ev)
                        -- Enable completion triggered by <c-x><c-o>
                        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border})
                        vim.lsp.handlers["textDocument/signatureHelp"] =
                            vim.lsp.with(vim.lsp.handlers.hover, {border = border})

                        -- Buffer local mappings.
                        -- See `:help vim.lsp.*` for documentation on any of the below functions
                        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {buffer = ev.buf, desc = "Declaration"})
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = ev.buf, desc = "Definition"})
                        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = ev.buf, desc = "Hover"})
                        vim.keymap.set(
                            "n",
                            "gi",
                            vim.lsp.buf.implementation,
                            {buffer = ev.buf, desc = "Implementation"}
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>wa",
                            vim.lsp.buf.add_workspace_folder,
                            {buffer = ev.buf, desc = "Add Workspace Folder"}
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>wr",
                            vim.lsp.buf.remove_workspace_folder,
                            {buffer = ev.buf, desc = "Remove Workspace Folder"}
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>wl",
                            function()
                                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                            end,
                            {buffer = ev.buf, desc = "List Workspace Folders"}
                        )
                        vim.keymap.set(
                            "n",
                            "gs",
                            vim.lsp.buf.type_definition,
                            {buffer = ev.buf, desc = "Type Definition"}
                        )
                        -- vim.keymap.set("n", "gr", vim.lsp.buf.rename, {buffer = ev.buf, desc = "Rename"})
                        vim.keymap.set("n", "gr", vim.lsp.buf.rename, {buffer = ev.buf, desc = "Rename"})
                        vim.keymap.set(
                            {"n", "v"},
                            "ga",
                            vim.lsp.buf.code_action,
                            {buffer = ev.buf, desc = "Code Action"}
                        )
                        vim.keymap.set("n", "gR", vim.lsp.buf.references, {buffer = ev.buf, desc = "References"})
                        -- vim.keymap.set('n', '<leader>f', function()
                        --   vim.lsp.buf.format { async = true }
                        -- end, opts)
                    end
                }
            )

            local lspconfig = require("lspconfig")

            -- Lua LSP
            lspconfig.lua_ls.setup(
                {
                    settings = {
                        Lua = {
                            runtime = {
                                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                version = "LuaJIT",
                                -- Setup your lua path
                                path = vim.split(package.path, ";")
                            },
                            diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = {"vim"}
                            },
                            workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                                }
                            }
                        }
                    }
                    -- on_attach = on_attach
                }
            )

            -- Nix LSP
            lspconfig.rnix.setup({})

            -- OCaml LSP
            lspconfig.ocamllsp.setup(
                {
                    root_dir = lspconfig.util.root_pattern("dune-project"),
                    capabilities = capabilities
                    -- on_attach = on_attach
                }
            )

            -- GO LSP
            lspconfig.gopls.setup({})

            -- Rust LSP
            -- rustaceanvim does not need these
            -- lspconfig.rust_analyzer.setup({})

            -- -- JSON
            -- lspconfig.jsonls.setup({})

            -- Python
            lspconfig.pyright.setup({})

            -- CSS
            lspconfig.cssls.setup({})

            -- C++
            lspconfig.clangd.setup({})

            -- Typescript LSP
            lspconfig.ts_ls.setup(
                {
                    init_options = {
                        hostInfo = "neovim",
                        preferences = {
                            includeInlayParameterNameHints = "none",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = false,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true
                        }
                    },
                    root_dir = lspconfig.util.root_pattern("tsconfig.json")
                    -- on_attach = function(client, bufnr)
                    --     on_attach(client, bufnr)
                    --     -- tsutils.setup {}
                    --     -- tsutils.setup_client(client)
                    -- end
                }
            )

            -- Tailwind CSS
            -- lspconfig.tailwindcss.setup({on_attach = on_attach})

            -- Setup Cursor highlight
            vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
            vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
            vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

            -- set up custom symbols for LSP errors
            local signs = {
                Error = icons.error,
                Warning = icons.warning,
                Warn = icons.warning,
                Hint = icons.hint,
                Info = icons.hint
            }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {text = icon, texthl = hl})
            end

            for _, method in ipairs({"textDocument/diagnostic", "workspace/diagnostic"}) do
                local default_diagnostic_handler = vim.lsp.handlers[method]
                vim.lsp.handlers[method] = function(err, result, context, config)
                    if err ~= nil and err.code == -32802 then
                        return
                    end
                    return default_diagnostic_handler(err, result, context, config)
                end
            end

            -- Set colors for completion items
            cmd("highlight! CmpItemAbbrMatch guibg=NONE guifg=" .. colors.lightblue)
            cmd("highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=" .. colors.lightblue)
            cmd("highlight! CmpItemKindFunction guibg=NONE guifg=" .. colors.magenta)
            cmd("highlight! CmpItemKindMethod guibg=NONE guifg=" .. colors.magenta)
            cmd("highlight! CmpItemKindVariable guibg=NONE guifg=" .. colors.blue)
            cmd("highlight! CmpItemKindKeyword guibg=NONE guifg=" .. colors.fg)
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
        build = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
}
