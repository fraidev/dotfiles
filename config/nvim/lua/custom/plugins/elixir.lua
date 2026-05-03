return {
    {
        "elixir-tools/elixir-tools.nvim",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            local elixirls_mod = require("elixir.elixirls")
            elixirls_mod.on_attach = function(client, bufnr)
                local add_user_cmd = vim.api.nvim_buf_create_user_command
                vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.codelens.enable(true, { bufnr = bufnr })
                    end,
                })
                vim.lsp.codelens.enable(true, { bufnr = bufnr })
                add_user_cmd(bufnr, "ElixirFromPipe", elixirls_mod.from_pipe(client), {})
                add_user_cmd(bufnr, "ElixirToPipe", elixirls_mod.to_pipe(client), {})
                add_user_cmd(bufnr, "ElixirRestart", elixirls_mod.restart(client), {})
                add_user_cmd(bufnr, "ElixirExpandMacro", elixirls_mod.expand_macro(client), { range = true })
                add_user_cmd(bufnr, "ElixirOutputPanel", function()
                    elixirls_mod.open_output_panel()
                end, {})
            end

            local elixir = require("elixir")

            elixir.setup({
                nextls = {enable = false},
                elixirls = {
                    enable = true,
                    settings = elixir.elixirls.settings({
                        dialyzerEnabled = true,
                        fetchDeps = false,
                        enableTestLenses = true,
                        suggestSpecs = true
                    })
                },
                projectionist = {enable = true}
            })
        end
    }
}
