require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
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
		config = {
			javascript = {
				__default = "// %s",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = "// %s",
				comment = "// %s",
				__parent = {
					-- if a node has this as the parent, use the `//` commentstring
					jsx_expression = "// %s",
				},
			},
			tsx = {
				jsx_element = {
					__default = "{/* %s */}",
					__parent = {
						parenthesized_expression = "// %s",
					},
				},
			},
		},
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
