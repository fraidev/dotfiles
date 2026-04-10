-- if vim.fn.filereadable("deno.jsonc") == 1 or vim.fn.filereadable("deno.json") == 1 then
    vim.lsp.enable("denols")
-- else
--     vim.lsp.enable("tsserver")
-- end

-- enable denofmt with neoformat
-- vim.g.neoformat_typescript_denofmt = {exe = "denofmt", args = {"--stdin"}, stdin = 1}
