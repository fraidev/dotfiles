local utils = require("utils")
local nnoremap = utils.nnoremap

local silent = { silent = true }

-- Terminal commands
-- ueoa is first through fourth finger left hand home row.
-- This just means I can crush, with opposite hand, the 4 terminal positions
--
-- These functions are stored in harpoon.  A plugn that I am developing
nnoremap("<leader>a", function()
	require("harpoon.mark").add_file()
end, silent)
nnoremap("<C-b>", function()
	require("harpoon.ui").toggle_quick_menu()
end, silent)
nnoremap("<leader>tc", function()
	require("harpoon.cmd-ui").toggle_quick_menu()
end, silent)

nnoremap("<F1>", function()
	require("harpoon.ui").nav_file(1)
end, silent)
nnoremap("<F2>", function()
	require("harpoon.ui").nav_file(2)
end, silent)
nnoremap("<F3>", function()
	require("harpoon.ui").nav_file(3)
end, silent)
nnoremap("<F4>", function()
	require("harpoon.ui").nav_file(4)
end, silent)
