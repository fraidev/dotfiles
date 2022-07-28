local lspkind = require("lspkind")
local cmp = require("cmp")

vim.o.completeopt = "menu,menuone,noselect"


cmp.setup(
  {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end
    },
    mapping = {
        ['<C-n>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
      ['<C-p>'] = cmp.mapping({
          c = function()
              if cmp.visible() then
                  cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                  vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
              end
          end,
          i = function(fallback)
              if cmp.visible() then
                  cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                  fallback()
              end
          end
      }),
      -- ["<Tab>"] = cmp.mapping({
      --     c = function()
      --         if cmp.visible() then
      --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      --         else
      --             cmp.complete()
      --         end
      --     end,
      --     i = function(fallback)
      --         if cmp.visible() then
      --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      --         elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
      --             vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
      --         else
      --             fallback()
      --         end
      --     end,
      --     s = function(fallback)
      --         if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
      --             vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
      --         else
      --             fallback()
      --         end
      --     end
      -- }),
      -- ["<S-Tab>"] = cmp.mapping({
      --     c = function()
      --         if cmp.visible() then
      --             cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      --         else
      --             cmp.complete()
      --         end
      --     end,
      --     i = function(fallback)
      --         if cmp.visible() then
      --             cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      --         elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
      --             return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
      --         else
      --             fallback()
      --         end
      --     end,
      --     s = function(fallback)
      --         if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
      --             return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
      --         else
      --             fallback()
      --         end
      --     end
      -- }),
      ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
      ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
      ["<C-j>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
      ["<C-k>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
      ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
        ['<CR>'] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end
        }),
    },
    sources = cmp.config.sources(
      {
        {name = "nvim_lsp"},
        {name = "vsnip"},
        {name = "nvim_lua"},
        {name = "buffer", keyword_length = 5, max_item_count = 5},
        {name = "path"}
      }
    ),
    formatting = {
      format = lspkind.cmp_format {
        with_text = true,
        menu = {
          nvim_lsp = "ﲳ",
          nvim_lua = "",
          path = "ﱮ",
          buffer = "﬘",
          vsnip = ""
          -- treesitter = "",
          -- zsh = "",
          -- spell = "暈"
        }
      }
    },
    experimental = {
      native_menu = false,
      ghost_text = true
    }
  }
)
