local lspkind = require("lspkind")
local cmp = require("cmp")

vim.o.completeopt = "menuone,noselect"

local menu = {
    nvim_lsp = "ﲳ",
    nvim_lua = "",
    path = "ﱮ",
    buffer = "﬘",
    vsnip = "",
    treesitter = "",
    zsh = "",
    spell = "暈"
}

cmp.setup(
    {
        preselect = cmp.PreselectMode.None,
        mapping = {
            ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}), {"i"}),
            ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}), {"i"}),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm(
                {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = false
                }
            ),
            ["<C-e>"] = cmp.mapping.close()
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        sources = {
            {name = "nvim_lsp"},
            {name = "nvim_lsp_signature_help"},
            {name = "nvim_lua"},
            {name = "luasnip"},
            {name = "path"},
            {name = "buffer"}
        },
        window = {
            documentation = cmp.config.window.bordered()
        },
        formatting = {
            format = lspkind.cmp_format(
                {
                    with_text = true,
                    before = function(entry, vim_item)
                        vim_item.menu =
                            string.format("%s %s", menu[entry.source.name], entry:get_completion_item().detail)
                        return vim_item
                    end
                }
            )
        },
        experimental = {
            native_menu = false,
            ghost_text = true
        }
    }
)
