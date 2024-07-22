vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

-- set log level
-- vim.lsp.set_log_level("debug")

-- obsidian settings
vim.opt_local.conceallevel = 1
-- package.path = package.path .. ";~/.luarocks/share/lua/5.1/magick/init.lua"

require("lazy").setup("custom.plugins")

local opt = vim.opt
local cmd = vim.cmd
local g = vim.g
local o = vim.o
local fn = vim.fn
local env = vim.env
local utils = require("utils")
local nmap = utils.nmap
local vmap = utils.vmap
local xnoremap = utils.xnoremap
local nnoremap = utils.nnoremap
local inoremap = utils.inoremap
local tnoremap = utils.tnoremap

vim.g.skip_ts_context_commentstring_module = true
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

opt.backup = false -- don't use backup files
opt.writebackup = false -- don't backup the file while editing
opt.swapfile = false -- don't create swap files for new buffers
opt.updatecount = 0 -- don't write swap files after some number of updates
opt.autoread = true --autoread

opt.backupdir = {
    "~/.vim-tmp",
    "~/.tmp",
    "~/tmp",
    "/var/tmp",
    "/tmp"
}

opt.directory = {
    "~/.vim-tmp",
    "~/.tmp",
    "~/tmp",
    "/var/tmp",
    "/tmp"
}

opt.history = 1000 -- store the last 1000 commands entered
opt.textwidth = 120 -- after configured number of characters, wrap line
opt.inccommand = "nosplit" -- show the results of substition as they're happening
-- opt.backspace = {"indent", "eol,start"} -- make backspace behave in a sane manner
opt.clipboard = {"unnamed", "unnamedplus"} -- use the system clipboard
opt.mouse = "a" -- set mouse mode to all modes
opt.splitright = true

-- searching
opt.ignorecase = true -- case insensitive searching
opt.smartcase = true -- case-sensitive if expresson contains a capital letter
opt.hlsearch = true -- highlight search results
opt.incsearch = true -- set incremental search, like modern browsers
opt.lazyredraw = false -- don't redraw while executing macros
opt.magic = true -- set magic on, for regular expressions

if fn.executable("rg") then
    -- if ripgrep installed, use that as a grepper
    opt.grepprg = "rg --vimgrep --no-heading"
    opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

-- error bells
opt.errorbells = false
opt.visualbell = true
opt.timeoutlen = 500

-- Appearance
---------------------------------------------------------
o.termguicolors = true
opt.termguicolors = true
opt.number = true -- show line numbers
opt.rnu = true
opt.wrap = true -- turn on line wrapping
opt.wrapmargin = 8 -- wrap lines when coming within n characters from side
opt.linebreak = true -- set soft wrapping
opt.showbreak = "↪"
opt.autoindent = true -- automatically set indent of new line
opt.ttyfast = true -- faster redrawing
table.insert(opt.diffopt, "vertical")
table.insert(opt.diffopt, "iwhite")
table.insert(opt.diffopt, "internal")
table.insert(opt.diffopt, "algorithm:patience")
table.insert(opt.diffopt, "hiddenoff")
opt.laststatus = 3 -- show the global statusline all the time
opt.scrolloff = 7 -- set 7 lines to the cursors - when moving vertical
opt.wildmenu = true -- enhanced command line completion
opt.hidden = true -- current buffer can be put into background
opt.showcmd = true -- show incomplete commands
opt.showmode = true -- don't show which mode disabled for PowerLine
opt.wildmode = {"list", "longest"} -- complete files like a shell
opt.shell = env.SHELL
opt.cmdheight = 1 -- command bar height
opt.title = true -- set terminal title
opt.showmatch = true -- show matching braces
opt.mat = 2 -- how many tenths of a second to blink
opt.updatetime = 300
opt.signcolumn = "yes"
opt.shortmess = "atToOFc" -- prompt message options

-- Tab control
opt.expandtab = true
opt.smartindent = true
opt.smarttab = true -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
opt.tabstop = 4 -- the visible width of tabs
opt.softtabstop = 4 -- edit as if the tabs are 4 characters wide
opt.shiftwidth = 4 -- number of spaces to use for indent and unindent

opt.shiftround = true -- round indent to a multiple of 'shiftwidth'

-- code folding settings
opt.foldmethod = "indent"
opt.foldnestmax = 10
opt.foldlevel = 2
opt.foldenable = false -- don't fold by default

-- toggle invisible characters
opt.list = true
opt.listchars = {
    tab = "→ ",
    eol = "¬",
    trail = "⋅",
    extends = "❯",
    precedes = "❮"
}
-- opt.pastetoggle = "<leader>v"
g.lazygit_floating_window_winblend = 0 --" transparency of floating window
g.lazygit_floating_window_scaling_factor = 0.9 --" scaling factor for floating window
g.lazygit_floating_window_use_plenary = 1 -- " use plenary.nvim to manage floating window if available
g.lazygit_use_neovim_remote = 1 --" fallback to 0 if neovim-remote is not installed
g.loaded_tutor_mode_plugin = 1
g.go_fmt_autosave = 0
g.go_imports_autosave = 0
g.suda_smart_edit = 1
g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25
cmd("set nolist")

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

cmd([[syntax on]])

if fn.has("nvim") then
    vim.env["GIT_EDITOR"] = "nvr -cc split --remote-wait"
end

-- nnoremap("<F12>", ":ToggleTerm<CR>")
-- inoremap("<F12>", "<Esc>:ToggleTerm<CR>")
-- tnoremap("<F12>", "<C-\\><C-n>:ToggleTerm<CR>")
require("toggleterm").setup {
    open_mapping = [[<F12>]],
    -- save editor before opening terminal
    -- on_open = function(term)
    --     -- local bufnr = vim.api.nvim_get_current_buf()
    --     -- -- local win = vim.api.nvim_get_current_win()
    --     -- vim.api.nvim_buf_call(bufnr, function()
    --     vim.cmd("w")
    --     -- end)
    --     -- vim.api.nvim_set_current_win(win)
    -- end
}

vim.filetype.add(
    {
        extension = {
            mdx = "markdown"
        }
    }
)
