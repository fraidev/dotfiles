local opt = vim.opt
local g = vim.g
local opt_local = vim.opt_local

----- Interesting Options -----

opt.termguicolors = true

-- You have to turn this one on :)
opt.inccommand = "split"

-- Best search settings :)
opt.smartcase = true
opt.ignorecase = true

----- Personal Preferences -----
opt.number = true
opt.relativenumber = true

opt.splitbelow = true
opt.splitright = true

opt.signcolumn = "yes"
opt.shada = {"'10", "<0", "s10", "h"}

opt.clipboard = "unnamedplus"

-- Don't have `o` add a comment
opt.formatoptions:remove "o"

opt.wrap = true
opt.linebreak = true


-- Disable adding EOL at the end of files
-- vim.opt.eol = false
vim.opt.fixeol = false

vim.opt.laststatus = 3

----- Obsidian -----
opt_local.conceallevel = 2 --" 0: no conceal, 1: conceal some, 2: conceal all

----- Global Variables -----

g.lazygit_floating_window_winblend = 0 --" transparency of floating window
g.lazygit_floating_window_scaling_factor = 0.9 --" scaling factor for floating window
g.lazygit_floating_window_use_plenary = 1 -- " use plenary.nvim to manage floating window if available
g.lazygit_use_neovim_remote = 1 --" fallback to 0 if neovim-remote is not installed
g.loaded_tutor_mode_plugin = 1
g.go_fmt_autosave = 0
g.go_imports_autosave = 0
g.suda_smart_edit = 1
