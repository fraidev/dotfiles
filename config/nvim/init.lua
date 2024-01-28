-- Neovim-specific configuration
-- require("config.lazy")

local opt = vim.opt
local cmd = vim.cmd
local g = vim.g
local o = vim.o
local fn = vim.fn
local env = vim.env
local utils = require("utils")
local nmap = utils.nmap
local vmap = utils.vmap
local imap = utils.imap
local xmap = utils.xmap
local xnoremap = utils.xnoremap
local omap = utils.omap
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
	"/tmp",
}

opt.directory = {
	"~/.vim-tmp",
	"~/.tmp",
	"~/tmp",
	"/var/tmp",
	"/tmp", }

opt.history = 1000 -- store the last 1000 commands entered
opt.textwidth = 120 -- after configured number of characters, wrap line
opt.inccommand = "nosplit" -- show the results of substition as they're happening
opt.backspace = { "indent", "eol,start" } -- make backspace behave in a sane manner
opt.clipboard = { "unnamed", "unnamedplus" } -- use the system clipboard
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
opt.wildmode = { "list", "longest" } -- complete files like a shell
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
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldlevelstart = 99
-- opt.foldnestmax = 10 -- deepest fold is 10 levels
opt.foldenable = false -- don't fold by default
-- opt.foldlevel = 1

-- toggle invisible characters
opt.list = true
opt.listchars = {
	tab = "→ ",
	eol = "¬",
	trail = "⋅",
	extends = "❯",
	precedes = "❮",
}
vim.g.mapleader = " "
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
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })

-- paste multiple
xnoremap("p", "pgvy")
nnoremap("Q", "<nop>")
-- imap("jj", "<Esc>")
-- imap("jj", "<Esc>")
nmap("<leader>,", ":w<cr>", { desc = "Save file" })
nmap(",,", "<C-w>10>", { desc = "Pull window horizontally" })
nmap(",.", "<C-w>10+", { desc = "Pull window vertically" })
nmap(".,", "<C-w>10-", { desc = "Push window vertically" })
nmap("..", "<C-w>10<", { desc = "Push window horizontally" })

nmap("U", ":redo<cr>")

nmap("<leader>c", [[:%s/]])
nmap("<leader><space>", ":noh<cr>")

-- show end of line marks like "¬"
nmap("<leader>l", ":set list!<cr>")

inoremap("<C-j>", [[v:lua.completion_nvim.smart_pumvisible('<C-n>', '<C-j>')]], { expr = true })
inoremap("<C-k>", [[v:lua.completion_nvim.smart_pumvisible('<C-p>', '<C-k>')]], { expr = true })
inoremap("<silent><esc>", "<esc>:update<cr>")
vmap("<", "<gv")
vmap(">", ">gv")
nmap("<leader>.", "<c-^>")
vmap(".", ":normal .<cr>")

nmap("<C-w>h", "<Plug>WinMoveLeft")
nmap("<C-w>j", "<Plug>WinMoveDown")
nmap("<C-w>k", "<Plug>WinMoveUp")
nmap("<C-w>l", "<Plug>WinMoveRight")

nmap("<C-h>", "<Plug>WinMoveLeft")
nmap("<C-j>", "<Plug>WinMoveDown")
nmap("<C-k>", "<Plug>WinMoveUp")
nmap("<C-l>", "<Plug>WinMoveRight")

-- helpers for dealing with other people's code
nmap([[\t]], ":set ts=4 sts=4 sw=4 noet<cr>")
nmap([[\s]], ":set ts=4 sts=4 sw=4 et<cr>")

nmap("<leader>gl", ":LazyGit<cr>")
nmap("<leader>gf", ":LazyGitFilter<cr>")
nmap("<leader>gc", ":LazyGitFilterCurrentFile")
nmap("<leader>lg", ":FloatermNew! git lg <cr>")
nmap("<leader>f", ":Neoformat <cr>")

-- Reload nvim
nmap("<leader><CR>", ":luafile %<cr>", { desc = "Reload nvim config" })

-- exit
nnoremap("<C-q>", ":x<cr>")
nnoremap("<leader>q", ":bd<cr>", { desc = "Close buffer" })

--moving up and down work as you would expect
nnoremap("j", 'v:count == 0 ? "gj" : "j"', { expr = true })
nnoremap("k", 'v:count == 0 ? "gk" : "k"', { expr = true })
nnoremap("^", 'v:count == 0 ? "g^" :  "^"', { expr = true })
nnoremap("$", 'v:count == 0 ? "g$" : "$"', { expr = true })

-- custom text objects
-- inner-line
xmap("il", ":<c-u>normal! g_v^<cr>")
omap("il", ":<c-u>normal! g_v^<cr>")
-- around line
vmap("al", ":<c-u>normal! $v0<cr>")
omap("al", ":<c-u>normal! $v0<cr>")

-- open current buffer in a new tab
nmap("gT", ":tab sb<cr>")
nmap("gT", ":tab sb<cr>")

cmd([[syntax on]])

if fn.has("nvim") then
	vim.env["GIT_EDITOR"] = "nvr -cc split --remote-wait"
end

require("plugins")
require("plugins.lspconfig")
require("plugins.completion")
require("winmove")

nnoremap("<leader>gr", ":Gread<cr>")
nnoremap("<leader>gb", ":G blame<cr>")
nnoremap("<leader>gg", ":Git<cr>")
nnoremap("<leader>gi", ":Gedit:<cr>")
nnoremap("<leader>gd", ":Gdiffsplit<cr>")



-- nnoremap('<F12>', ':ToggleTerm<CR>')
-- inoremap('<F12>', '<Esc>:ToggleTerm<CR>')
-- tnoremap('<F12>', '<C-\\><C-n>:ToggleTerm<CR>')
require("toggleterm").setup{
    open_mapping = [[<F12>]],
}
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- local Terminal  = require('toggleterm.terminal').Terminal
-- local lazygit = Terminal:new({
--   cmd = "lazygit",
--   dir = "git_dir",
--   direction = "float",
--   float_opts = {
--     border = "double",
--   },
--   -- function to run on opening the terminal
--   on_open = function(term)
--     vim.cmd("startinsert!")
--     vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
--     vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<ESC>", "<cmd>close<CR>", {noremap = true, silent = true})
--   end,
--   -- function to run on closing the terminal
--   on_close = function(_)
--     vim.cmd("startinsert!")
--   end,
-- })

-- function Lazygit_toggle()
--   lazygit:toggle()
-- end

-- vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>lua Lazygit_toggle()<CR>", {noremap = true, silent = true})
