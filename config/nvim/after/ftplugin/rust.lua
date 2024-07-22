-- Don't do comment stuffs when I use o/O
vim.opt_local.formatoptions:remove "o"

-- vim.keymap.set("n", "<F5>", function()
--   if require("dap").session() then
--     require("dap").continue()
--   else
--     vim.cmd('DapNew')
--   end
-- end)

-- vim.lsp.inlay_hint.enable()
