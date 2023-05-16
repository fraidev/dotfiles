require("nvim-treesitter.configs").setup({
	ensure_installed = {
		-- "bash",
		"css",
		"html",
		"ocaml",
		"javascript",
		"lua",
		"python",
		"rust",
		"ocaml",
		"go",
		"typescript",
		"vim",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	context_commentstring = {
		enable = true,
	},
	rainbow = {
		enable = false,
		extended_mode = false,
		max_file_lines = 1000,
	},
})
require("spellsitter").setup({
	enable = true,
	debug = false,
})
