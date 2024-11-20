return {
    "sbdchd/neoformat",
    config = function()
        vim.g.neoformat_cs_csharpier = {exe = "csharpier", args = {}, stdin = 1}
        vim.g.neoformat_rust_rustfmt = {exe = "rustfmt", args = {"--edition=2021"}, stdin = 1}
    end
}
