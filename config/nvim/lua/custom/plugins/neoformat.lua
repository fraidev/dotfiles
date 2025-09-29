return {
    "sbdchd/neoformat",
    config = function()
        vim.g.neoformat_cs_csharpier = {exe = "csharpier", args = {}, stdin = 1}
        vim.g.neoformat_rust_rustfmt = {exe = "rustfmt", args = {"--edition=2024"}, stdin = 1}
        -- vim.g.neoformat_rust_rustfmt = {exe = "rustfmt", stdin = 1}
        vim.g.neoformat_python_black = {exe = "black", args = {}, stdin = 1}
        vim.g.neoformat_zig_zigfmt = {exe = "zig", args = {"fmt", "--stdin"}, stdin = 1}
	-- vim.g.neoformat_verbose = 1
    end
}
