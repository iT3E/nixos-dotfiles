local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()

-- Basic keymaps
vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end,
    { desc = "Add file to harpoon" })
vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = "Show harpoon menu" })

-- Navigation keymaps
vim.keymap.set("n", "<C-h><C-h>", function() harpoon:list():select(1) end,
    { desc = "Navigate to file 1" })
vim.keymap.set("n", "<C-h><C-j>", function() harpoon:list():select(2) end,
    { desc = "Navigate to file 2" })
vim.keymap.set("n", "<C-h><C-k>", function() harpoon:list():select(3) end,
    { desc = "Navigate to file 3" })
vim.keymap.set("n", "<C-h><C-l>", function() harpoon:list():select(4) end,
    { desc = "Navigate to file 4" })
