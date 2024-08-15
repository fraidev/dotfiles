local g = vim.g
local utils = require("utils")
local nmap = utils.nmap
local vmap = utils.vmap
local xnoremap = utils.xnoremap
local nnoremap = utils.nnoremap

g.lazygit_floating_window_winblend = 0 --" transparency of floating window
g.lazygit_floating_window_scaling_factor = 0.9 --" scaling factor for floating window
g.lazygit_floating_window_use_plenary = 1 -- " use plenary.nvim to manage floating window if available
g.lazygit_use_neovim_remote = 1 --" fallback to 0 if neovim-remote is not installed
g.loaded_tutor_mode_plugin = 1
g.go_fmt_autosave = 0
g.go_imports_autosave = 0
g.suda_smart_edit = 1

-- Mappings
nnoremap("<space>", "<nop>")
vim.keymap.set("n", "<Space>", "<Nop>", {silent = true, remap = false})

-- paste multiple
xnoremap("p", "pgvy")
nmap("<leader>,", ":w<cr>", {desc = "Save file"})
nmap(",,", "<C-w>10>", {desc = "Pull window horizontally"})
nmap(",.", "<C-w>10+", {desc = "Pull window vertically"})
nmap(".,", "<C-w>10-", {desc = "Push window vertically"})
nmap("..", "<C-w>10<", {desc = "Push window horizontally"})

nmap("U", ":redo<cr>")

nmap("<leader>c", [[:%s/]])
nmap("<leader><space>", ":noh<cr>")

vmap("<", "<gv")
vmap(">", ">gv")
nmap("<leader>.", "<c-^>")
vmap(".", ":normal .<cr>")

nmap("<leader>f", ":Neoformat <cr>")

-- exit
-- nnoremap("<C-q>", ":x<cr>")
nnoremap("<leader>q", ":bd<cr>", {desc = "Close buffer"})

nnoremap("<leader>bo", "<cmd>%bd|e#<cr>", {desc = "Close all buffers but the current one"})

--moving up and down work as you would expect
nnoremap("j", 'v:count == 0 ? "gj" : "j"', {expr = true})
nnoremap("k", 'v:count == 0 ? "gk" : "k"', {expr = true})
nnoremap("^", 'v:count == 0 ? "g^" :  "^"', {expr = true})
nnoremap("$", 'v:count == 0 ? "g$" : "$"', {expr = true})

nnoremap(
    "<leader>ti",
    ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
    {desc = "Toggle inlay hints"}
)
