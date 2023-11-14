local utils = require("utils")
local nmap = utils.nmap
local cmd = vim.cmd
local api = vim.api
local fn = vim.fn
local lsp = vim.lsp
local mason = require("mason")
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local theme = require("theme")
local colors = theme.colors
local icons = theme.icons
local rust_tools = require("rust-tools")

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

local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end
    if not api.nvim_buf_get_option(bufnr, "modified") then
        local view = fn.winsaveview()
        lsp.util.apply_text_edits(result, bufnr)
        fn.winrestview(view)
        if bufnr == api.nvim_get_current_buf() then
            api.nvim_command("noautocmd :update")
        end
    end
end

lsp.handlers["textDocument/formatting"] = format_async

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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

local on_attach = function(client, bufnr)
    cmd([[command! LspFormatting lua vim.lsp.buf.formatting()]])
    cmd([[command! LspCodeAction lua vim.lsp.buf.code_action()]])
    cmd([[command! LspHover lua vim.lsp.buf.hover()]])
    cmd([[command! LspRename lua vim.lsp.buf.rename()]])
    cmd([[command! LspOrganize lua lsp_organize_imports()]])
    cmd([[command! OR lua lsp_organize_imports()]])
    cmd([[command! LspRefs lua vim.lsp.buf.references()]])
    cmd([[command! LspDec lua vim.lsp.buf.declaration()]])
    cmd([[command! LspDef lua vim.lsp.buf.definition()]])
    cmd([[command! LspTypeDef lua vim.lsp.buf.type_definition()]])
    cmd([[command! LspImplementation lua vim.lsp.buf.implementation()]])
    cmd([[command! LspDiagPrev lua vim.diagnostic.goto_prev()]])
    cmd([[command! LspDiagNext lua vim.diagnostic.goto_next()]])
    cmd([[command! LspDiagLine lua lsp_show_diagnostics()]])
    cmd([[command! LspSignatureHelp lua vim.lsp.buf.signature_help()]])

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border})
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border})

    lsp.handlers["textDocument/publishDiagnostics"] =
        lsp.with(
        lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false
        }
    )

    nmap("gd", ":LspDef<CR>", {bufnr = bufnr})
    nmap("gD", ":LspImplementation<CR>", {bufnr = bufnr})
    nmap("gr", ":LspRename<CR>", {bufnr = bufnr})
    nmap("gR", ":LspRefs<CR>", {bufnr = bufnr})
    nmap("gy", ":LspTypeDef<CR>", {bufnr = bufnr})
    nmap("K", ":LspHover<CR>", {bufnr = bufnr})
    nmap("gs", ":LspOrganize<CR>", {bufnr = bufnr})
    nmap("[a", ":LspDiagPrev<CR>", {bufnr = bufnr})
    nmap("]a", ":LspDiagNext<CR>", {bufnr = bufnr})
    nmap("ga", ":LspCodeAction<CR>", {bufnr = bufnr})
    nmap("<Leader>d", ":LspDiagLine<CR>", {bufnr = bufnr})
    -- imap("<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", {bufnr = bufnr})

    if client.server_capabilities.document_highlight then
        api.nvim_exec(
            [[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
            false
        )
    end

    -- disable document formatting (currently handled by formatter.nvim)
    client.server_capabilities.documentFormattingProvider = false

    if client.server_capabilities.documentFormattingProvider then
        api.nvim_exec(
            [[
        augroup LspAutocommands
        autocmd! * <buffer>
        autocmd BufWritePost <buffer> LspFormatting
        augroup END
      ]],
            true
        )
    end

    if client.name == "omnisharp" or client.name == "omnisharp_mono" then
        client.server_capabilities.semanticTokensProvider = nil
    end

    if client.name == "ocamllsp" then
        client.get_language_id = function(_, ftype)
            return ftype
        end
    end

    -- require("illuminate").on_attach(client)
end

mason_lspconfig.setup()

-- mason_lspconfig.setup_handlers {
--     -- This is a default handler that will be called for each installed server (also for new servers that are installed during a session)
--   -- function (server_name)
--   --   lspconfig[server_name].setup {
--   --     on_attach = on_attach,
--   --     -- flags = lsp_flags,
--   --   }
--   -- end,
-- }

-- Lsp Installer
mason.setup(
    {
        on_attach = on_attach,
        automatic_installation = true
    }
)
-- mason.setup(
--     {
--         on_attach = on_attach,
--         automatic_installation = false
--     }
-- )

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
        },
        on_attach = on_attach
    }
)

-- Nix LSP
lspconfig.rnix.setup({})

-- OCaml LSP
lspconfig.ocamllsp.setup(
    {
        root_dir = lspconfig.util.root_pattern("dune-project"),
        capabilities = capabilities,
        on_attach = on_attach
    }
)

-- GO LSP
lspconfig.gopls.setup(
    {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
        end
    }
)

-- Rust LSP
rust_tools.setup(
    {
        server = {
            -- on_attach = function(_, bufnr)
            --   -- Hover actions
            --   vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
            --   -- Code action groups
            --   vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
            -- end,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
            end
        }
    }
)

-- lspconfig.rust_analyzer.setup({
-- 	on_attach = function(client, bufnr)
-- 		on_attach(client, bufnr)
-- 	end,
--   flags = {
--     exit_timeout = 0,
--   }
-- })

-- GraphQL
-- lspconfig.graphql.setup { on_attach = on_attach }

-- JSON
lspconfig.jsonls.setup({on_attach = on_attach})

-- Python
lspconfig.pyright.setup({on_attach = on_attach})

-- CSS
lspconfig.cssls.setup({on_attach = on_attach})

-- C++
lspconfig.clangd.setup({on_attach = on_attach})

-- C#
-- lspconfig.omnisharp_mono.setup(
--     {
--         root_dir = lspconfig.util.root_pattern("*.csproj", "*.sln", ".git"),
--         on_attach = on_attach,
--         capabilities = vim.tbl_deep_extend(
--             "force",
--             capabilities,
--             {
--                 workspace = {
--                     didChangeWatchedFiles = {
--                         dynamicRegistration = true
--                     }
--                 }
--             }
--         )
--     }
-- )
lspconfig.omnisharp_mono.setup(
    {
        handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler
        },
        cmd = {
            "mono",
            "--assembly-loader=strict",
            "/Users/frai/.vscode/extensions/ms-dotnettools.csharp-1.25.9-darwin-arm64/.omnisharp/1.39.6/omnisharp/OmniSharp.exe",
            "--loglevel",
            "information",
            "--plugin",
            "/Users/frai/.vscode/extensions/ms-dotnettools.csharp-1.25.9-darwin-arm64/.razor/OmniSharpPlugin/Microsoft.AspNetCore.Razor.OmniSharpPlugin.dll"
        },
        root_dir = lspconfig.util.root_pattern("*.csproj", "*.sln", ".git"),
        use_mono = true,
        on_attach = on_attach,
        -- capabilities = capabilities
        capabilities = vim.tbl_deep_extend(
            "force",
            capabilities,
            {
                workspace = {
                    didChangeWatchedFiles = {
                        dynamicRegistration = true
                    }
                }
            }
        )
    }
)

-- Deno LSP
-- lspconfig.denols.setup({
--     on_attach = on_attach,
--     root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
-- })

-- Typescript LSP
lspconfig.tsserver.setup(
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
        root_dir = lspconfig.util.root_pattern("tsconfig.json"),
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            -- tsutils.setup {}
            -- tsutils.setup_client(client)
        end
    }
)

-- Tailwind CSS
-- lspconfig.tailwindcss.setup({on_attach = on_attach})

-- Setup Cursor highlight
vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

-- set up custom symbols for LSP errors
local signs = {Error = icons.error, Warning = icons.warning, Warn = icons.warning, Hint = icons.hint, Info = icons.hint}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl})
end

-- Set colors for completion items
cmd("highlight! CmpItemAbbrMatch guibg=NONE guifg=" .. colors.lightblue)
cmd("highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=" .. colors.lightblue)
cmd("highlight! CmpItemKindFunction guibg=NONE guifg=" .. colors.magenta)
cmd("highlight! CmpItemKindMethod guibg=NONE guifg=" .. colors.magenta)
cmd("highlight! CmpItemKindVariable guibg=NONE guifg=" .. colors.blue)
cmd("highlight! CmpItemKindKeyword guibg=NONE guifg=" .. colors.fg)
