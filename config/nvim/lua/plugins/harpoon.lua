local harpoon = require("harpoon")
local nnoremap = vim.keymap.nnoremap

harpoon:setup()


-- nnoremap { "<leader>ha", function() harpoon.ui.toggle_quick_menu() end }

-- vim.keymap.set(
--     "n",
--     "<leader>a",
--     function()
--         harpoon:list():append()
--     end
-- )
-- vim.keymap.set(
--     "n",
--     "<C-b>",
--     function()
--         harpoon.ui:toggle_quick_menu(harpoon:list())
--     end
-- )
-- vim.keymap.set(
--     "n",
--     "<leader>tc",
--     function()
--         harpoon.ui:toggle_quick_menu(harpoon:list())
--     end
-- )

-- vim.keymap.set(
--     "n",
--     "<F1>",
--     function()
--         harpoon:list():select(1)
--     end
-- )
-- vim.keymap.set(
--     "n",
--     "<F2>",
--     function()
--         harpoon:list():select(2)
--     end
-- )
-- vim.keymap.set(
--     "n",
--     "<F3>",
--     function()
--         harpoon:list():select(3)
--     end
-- )
-- vim.keymap.set(
--     "n",
--     "<F4>",
--     function()
--         harpoon:list():select(4)
--     end
-- )
