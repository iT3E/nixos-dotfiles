-- harpoon configuration
require("harpoon2").setup({
  settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
      key = function()
          return vim.loop.cwd()
      end,
  },
})
