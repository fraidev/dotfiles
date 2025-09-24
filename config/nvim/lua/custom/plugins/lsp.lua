-- Mason lsp plugin
return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                "williamboman/mason.nvim",
                build = ":MasonUpdate" -- :MasonUpdate updates registry contents
            }
            -- {
            --     "j-hui/fidget.nvim",
            --     opts = {}
            -- }
        },
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

            local capabilities = nil
            if pcall(require, "cmp_nvim_lsp") then
                capabilities = require("cmp_nvim_lsp").default_capabilities()
            end

            -- _G makes this function available to vimscript lua calls
            _G.lsp_organize_imports = function()
                local params = {
                    command = "_typescript.organizeImports",
                    arguments = {api.nvim_buf_get_name(0)},
                    title = ""
                }
                lsp.buf.execute_command(params)
            end

            vim.keymap.set("n", "<leader>od", vim.diagnostic.open_float)
            vim.keymap.set(
                "n",
                "[a",
                function()
                    vim.diagnostic.jump({count = -1, float = true})
                end
            )
            vim.keymap.set(
                "n",
                "]a",
                function()
                    vim.diagnostic.jump({count = 1, float = true})
                end
            )
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
                    end
                }
            )

            -- lsp.config(
            --     "rust_analyzer",
            --     {
            --         settings = {
            --             ["rust-analyzer"] = {
            --                 checkOnSave = {
            --                     command = "clippy"
            --                 },
            --                 cargo = {
            --                     allFeatures = true
            --                 }
            --             }
            --         },
            --         capabilities = capabilities
            --     }
            -- )

            -- local lspconfig = require("lspconfig")
            local lspconfig = vim.lsp.config

            -- Lua LSP
            lspconfig(
                "lua_ls",
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
            lspconfig("rnix", {})

            -- OCaml LSP
            lspconfig(
                "ocamllsp",
                {
                    root_dir = require("lspconfig").util.root_pattern("dune-project"),
                    capabilities = capabilities
                    -- on_attach = on_attach
                }
            )

            -- GO LSP
            lspconfig("gopls", {})

            -- Python

            -- lspconfig("pylsp",
            --     {
            --         settings = {
            --             pylsp = {
            --                 plugins = {
            --                     pyflakes = {enabled = false},
            --                     pycodestyle = {enabled = false},
            --                     autopep8 = {enabled = false},
            --                     yapf = {enabled = false},
            --                     mccabe = {enabled = false},
            --                     pylsp_mypy = {enabled = false},
            --                     pylsp_black = {enabled = false},
            --                     pylsp_isort = {enabled = false}
            --                 }
            --             }
            --         }
            --     }
            -- )

            lspconfig(
                "basedpyright",
                {
                    settings = {
                        basedpyright = {
                            disableOrganizeImports = true, -- Using Ruff's import organizer
                            disableLanguageServices = false,
                            analysis = {
                                ignore = {"*"}, -- Ignore all files for analysis to exclusively use Ruff for linting
                                -- typeCheckingMode = "off",
                                diagnosticMode = "openFilesOnly", -- Only analyze open files
                                autoImportCompletions = true, -- whether pyright offers auto-import completions
                                autoSearchPath = true,
                                -- typeCheckingMode = "basic",
                                useLibraryCodeForTypes = true,
                                -- diagnosticMode = "workspace",
                                inlayHints = {
                                    callArgumentNames = true
                                }
                            }
                        }
                    }
                    -- capabilities = capabilities
                }
            )

            -- CSS
            lspconfig("cssls", {})

            -- Svelte LSP
            lspconfig(
                "svelte",
                {
                    capabilities = capabilities,
                    settings = {
                        svelte = {
                            plugin = {
                                html = {
                                    completions = {
                                        enable = true,
                                        emmet = false
                                    }
                                },
                                svelte = {
                                    completions = {
                                        enable = true
                                    }
                                },
                                css = {
                                    completions = {
                                        enable = true,
                                        emmet = true
                                    }
                                }
                            }
                        }
                    }
                }
            )

            -- C++
            lspconfig("clangd", {})

            -- Typescript LSP
            lspconfig(
                "ts_ls",
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
                    root_dir = require("lspconfig").util.root_pattern("tsconfig.json")
                }
            )

            -- Setup Cursor highlight
            -- vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
            -- vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
            -- vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

            -- set up custom symbols for LSP errors
            local signs = {
                Error = icons.error,
                Warning = icons.warning,
                Warn = icons.warning,
                Hint = icons.hint,
                Info = icons.hint
            }
            vim.diagnostic.config(
                {
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = signs.Error,
                            [vim.diagnostic.severity.WARN] = signs.Warning,
                            [vim.diagnostic.severity.HINT] = signs.Hint,
                            [vim.diagnostic.severity.INFO] = signs.Info
                        }
                    }
                }
            )

            for _, method in ipairs({"textDocument/diagnostic", "workspace/diagnostic"}) do
                local default_diagnostic_handler = vim.lsp.handlers[method]
                vim.lsp.handlers[method] = function(err, result, context, config)
                    if err ~= nil and err.code == -32802 then
                        return
                    end
                    return default_diagnostic_handler(err, result, context, config)
                end
            end

            vim.diagnostic.config(
                {
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = " ",
                            [vim.diagnostic.severity.WARN] = " ",
                            [vim.diagnostic.severity.HINT] = "󰠠 ",
                            [vim.diagnostic.severity.INFO] = " "
                        }
                    }
                }
            )

            vim.lsp.config(
                "*",
                {
                    capabilities = capabilities
                }
            )

            vim.lsp.config(
                "svelte",
                {
                    on_attach = function(client, bufnr)
                        vim.api.nvim_create_autocmd(
                            "BufWritePost",
                            {
                                pattern = {"*.js", "*.ts"},
                                callback = function(ctx)
                                    -- Here use ctx.match instead of ctx.file
                                    client.notify("$/onDidChangeTsOrJsFile", {uri = ctx.match})
                                end
                            }
                        )
                    end
                }
            )

            vim.lsp.config(
                "graphql",
                {
                    filetypes = {"graphql", "gql", "svelte", "typescriptreact", "javascriptreact"}
                }
            )

            vim.lsp.config(
                "emmet_ls",
                {
                    filetypes = {"html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte"}
                }
            )

            vim.lsp.config(
                "eslint",
                {
                    filetypes = {"html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte"}
                }
            )

            vim.lsp.config(
                "lua_ls",
                {
                    settings = {
                        Lua = {
                            -- make the language server recognize "vim" global
                            diagnostics = {
                                globals = {"vim"}
                            },
                            completion = {
                                callSnippet = "Replace"
                            }
                        }
                    }
                }
            )

            -- Set colors for completion items
            cmd("highlight! CmpItemAbbrMatch guibg=NONE guifg=" .. colors.lightblue)
            cmd("highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=" .. colors.lightblue)
            cmd("highlight! CmpItemKindFunction guibg=NONE guifg=" .. colors.magenta)
            cmd("highlight! CmpItemKindMethod guibg=NONE guifg=" .. colors.magenta)
            cmd("highlight! CmpItemKindVariable guibg=NONE guifg=" .. colors.blue)
            cmd("highlight! CmpItemKindKeyword guibg=NONE guifg=" .. colors.fg)
        end
    }
}
